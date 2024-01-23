import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    let networkWeatherManager = NetworkWeatherManager()
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { cityName in
            self.networkWeatherManager.fetchCurrentWeather(forCity: cityName) { currentWeather in
                DispatchQueue.main.async {
                    self.cityLabel.text = currentWeather.cityName
                    self.temperatureLabel.text = currentWeather.currentTemperatureString
                    self.feelsLikeTemperatureLabel.text = currentWeather.feelsLikeTemperatureString
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.networkWeatherManager.fetchCurrentWeather(forCity: cityLabel.text!) { currentWeather in
            DispatchQueue.main.async {
                self.cityLabel.text = currentWeather.cityName
                self.temperatureLabel.text = currentWeather.currentTemperatureString
                self.feelsLikeTemperatureLabel.text = currentWeather.feelsLikeTemperatureString
            }
        }
        
    }
}


