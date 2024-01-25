

import Foundation

struct CurrentWeather {
    
    let cityName: String
    
    private let currentTemperature: Double
    var currentTemperatureString: String {
        return String(format: "%.0f", currentTemperature.rounded())
    }
    
    private let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return String(format: "%.0f", feelsLikeTemperature.rounded())
    }
    
    private let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 1000: return "sun.max.fill"
        case 1003, 1009: return "cloud.fill"
        case 1030, 1135, 1147: return "cloud.fog.fill"
        case 1063, 1180, 1186: return "cloud.sun.rain.fill"
        case 1150, 1153, 1171: return "cloud.drizzle.fill"
        case 1183, 1189, 1192, 1195, 1198, 1201, 1072, 1240, 1243, 1246: return "cloud.rain.fill"
        case 1066, 1069, 1204, 1114, 1117, 1207, 1210, 1213, 1216, 1219, 1222, 1225, 1237, 1249, 1252, 1255, 1258, 1261, 1264, 1279, 1282 : return "cloud.snow.fill"
        case 1087, 1273, 1276: return "cloud.bolt.rain.fill"
        default: return "icloud.slash.fill"
        }
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        self.cityName = currentWeatherData.location.name
        self.currentTemperature = currentWeatherData.current.temp
        self.feelsLikeTemperature = currentWeatherData.current.feelsLike
        self.conditionCode = currentWeatherData.current.condition.code
    }
    
}
