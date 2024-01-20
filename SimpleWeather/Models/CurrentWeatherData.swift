import Foundation

struct CurrentWeatherData: Decodable {
    let location: Location
    let current: Current
}

struct Location: Decodable {
    let name: String
}

struct Current: Decodable {
    let temp: Int
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp_c"
        case feelsLike = "feelslike_c"
    }
    
}
