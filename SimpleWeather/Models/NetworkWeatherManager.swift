import Foundation

struct NetworkWeatherManager {
    
    func fetchCurrentWeather(for city: String) {
        let urlString = "https://api.weatherapi.com/v1/current.json?q=\(city)&key=\(Constants.apiKey)"
        
        let session = URLSession(configuration: .default)
        if let url = URL(string: urlString) {
            let dataTask = session.dataTask(with: url) { data, response, error in
                if let data = data {
                    self.parseJSON(with: data)
                }
            }
            dataTask.resume()
        }
    }
    
    func parseJSON(with data: Data) {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            print(currentWeatherData.current.temp)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
}
