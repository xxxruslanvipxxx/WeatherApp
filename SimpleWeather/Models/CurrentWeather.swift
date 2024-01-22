

import Foundation

struct CurrentWeather {
    
    let cityName: String
    
    let currentTemperature: Int
    var currentTemperatureString: String {
        return "\(currentTemperature)"
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return "\(feelsLikeTemperature.rounded())"
    }
    
    let conditionCode: Int
    
    init?(currentWeatherData: CurrentWeatherData) {
        self.cityName = currentWeatherData.location.name
        self.currentTemperature = currentWeatherData.current.temp
        self.feelsLikeTemperature = currentWeatherData.current.feelsLike
        self.conditionCode = currentWeatherData.current.condition.code
    }
    
}
