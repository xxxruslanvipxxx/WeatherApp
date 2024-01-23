

import Foundation

struct CurrentWeather {
    
    let cityName: String
    
    let currentTemperature: Double
    var currentTemperatureString: String {
        return "\(currentTemperature.rounded())"
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
