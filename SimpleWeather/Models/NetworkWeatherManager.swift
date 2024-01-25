import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.weatherapi.com/v1/current.json?q=\(city)&key=\(Constants.apiKey)"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.weatherapi.com/v1/current.json?q=\(latitude),\(longitude)&key=\(Constants.apiKey)"
        }
        
        performRequest(withURLString: urlString)
    }
    
    fileprivate func performRequest(withURLString urlString: String) {
        let session = URLSession(configuration: .default)
        if let url = URL(string: urlString) {
            let dataTask = session.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let currentWeather = self.parseJSON(withData: data) {
                        self.onCompletion?(currentWeather)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    fileprivate func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
