//
//  CurrentWeather.swift
//  NooroWeather
//
//  Created by Kevin Sullivan on 1/25/25.
//

import Foundation

struct CurrentWeatherResponse: Codable {
    var location: Location
    var current: CurrentWeather
}

struct Location: Codable {
    var name: String
}

struct CurrentWeather: Codable {
    var temperature: Double
    var condition: WeatherCondition
    var humidity: Double
    var uvIndex: Double
    var feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp_f"
        case condition
        case humidity
        case uvIndex = "uv"
        case feelsLike = "feelslike_f"
    }
}

struct WeatherCondition: Codable {
    var text: String
    var icon: String
}
