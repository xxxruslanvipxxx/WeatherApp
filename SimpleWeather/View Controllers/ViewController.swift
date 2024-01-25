import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [weak self] cityName in
            self?.networkWeatherManager.fetchCurrentWeather(forCity: cityName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else {return}
            self.updateInterface(with: currentWeather)
        }
        self.networkWeatherManager.fetchCurrentWeather(forCity: cityLabel.text!)
    }
    
    private func updateInterface(with weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.currentTemperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLikeTemperatureString
            
            let imageString = weather.systemIconNameString
            print(imageString)
            if let image = UIImage(systemName: imageString) {
                self.weatherIconImageView.image = image
            }
        }
    }
}
