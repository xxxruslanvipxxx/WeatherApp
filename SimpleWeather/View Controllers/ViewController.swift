import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    var networkWeatherManager = NetworkWeatherManager()
    
    var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [unowned self] cityName in
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: cityName))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.networkWeatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else {return}
            self.updateInterface(with: currentWeather)
        }
        
        locationManager.delegate = self
        DispatchQueue.global().async {
          if CLLocationManager.locationServicesEnabled() {
              self.locationManager.requestLocation()
          }
        }
    }
    
    private func updateInterface(with weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.currentTemperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLikeTemperatureString
            let imageString = weather.systemIconNameString
            if let image = UIImage(systemName: imageString) {
                self.weatherIconImageView.image = image
            }
        }
    }
}

//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
