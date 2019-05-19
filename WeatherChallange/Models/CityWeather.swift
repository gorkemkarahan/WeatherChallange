//
//  Forecast.swift
//  WeatherChallange
//
//  Created by Görkem Karahan on 19.05.2019.
//  Copyright © 2019 Görkem Karahan. All rights reserved.
//

struct CityWeather: Codable {
    
    /// Internal parameter
    let cod: String
    
    /// Internal parameter
    let message: Double
    
    /// Number of lines returned by this API call
    let cnt: Int
    
    /// City Information
    let city: City
    
    /// List of caluclations
    let list: [Forecast]
}

struct City: Codable {
    
    /// City ID
    let id: Int
    
    /// City Name
    let name: String
    
    /// City Coordinates
    let coord: Coordinates
    
    /// Country code (GB, JP etc.)
    let country: String
}

struct Coordinates: Codable {
    
    /// City geo location, latitude
    let lat: Double
    
    /// City geo location, longitude
    let lon: Double
}

struct Forecast: Codable {
    
    /// Time of data forecasted, unix, UTC
    let dt: Double
    
    /// General information about forecast
    let main: ForecastMain
    
    /// Weather condition
    let weather: [ForecastWeather]
    
    /// Cloud condition
    let clouds: ForecastClouds?
    
    /// Wind condition
    let wind: ForecastWind?
    
    /// Rain condition
    let rain: ForecastRain?
    
    /// Snow condition
    let snow: ForecastSnow?
    
    /// Data/time of calculation, UTC
    let dtTxt: String
    
    //NOTE: Just convert snake case to camel case
    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case clouds
        case wind
        case rain
        case snow
        case dtTxt = "dt_txt"
    }
}

struct ForecastMain: Codable {
    
    /// Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    let temp: Double
    
    /// Minimum temperature at the moment of calculation. This is deviation from 'temp' that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    let tempMin: Double
    
    /// Maximum temperature at the moment of calculation. This is deviation from 'temp' that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    let tempMax: Double
    
    /// Atmospheric pressure on the sea level by default, hPa
    let pressure: Double
    
    /// Atmospheric pressure on the sea level, hPa
    let seaLevel: Double
    
    ///  Atmospheric pressure on the ground level, hPa
    let grndLevel: Double
    
    ///  Humidity, %
    let humidity: Double
    
    /// Internal parameter
    let tempKf: Double
    
    //NOTE: Just convert snake case to camel case
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct ForecastWeather: Codable {
    
    /// Weather condition id
    let id: Int
    
    /// Group of weather parameters (Rain, Snow, Extreme etc.)
    let main: String
    
    ///  Weather condition within the group
    let description: String
    
    /// Weather icon id
    let icon: String
    
    func getIconUrlString() -> String {
        return "https://openweathermap.org/img/w/\(icon).png"
        
    }
}

struct ForecastClouds: Codable {
    
    /// Cloudiness, %
    let all: Double
}

struct ForecastWind: Codable {
    
    /// Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
    let speed: Double
    
    /// Wind direction, degrees (meteorological)
    let deg: Double
}

//NOTE: Sometimes even though there is Rain object in the response it does not contain 3h key so it shoul be optional
struct ForecastRain: Codable {
    
    /// Rain volume for last 3 hours, mm
    let threeHours: Double?
    
    //NOTE: Necessary since 3h can not be represented as variable name
    enum CodingKeys: String, CodingKey {
        case threeHours = "3h"
    }

}

//NOTE: Sometimes even though there is Snow object in the response it does not contain 3h key so it shoul be optional
struct ForecastSnow: Codable {
    
    /// Snow volume for last 3 hours
    let threeHours: Double?
    
    //NOTE: Necessary since 3h can not be represented as variable name
    enum CodingKeys: String, CodingKey {
        case threeHours = "3h"
    }
}
