//
//  WeatherSearchResult.swift
//  NooroWeather
//
//  Created by Kevin Sullivan on 1/25/25.
//

import Foundation

struct WeatherSearchResult: Codable, Identifiable, Hashable {
    var id: Int
    var name: String
}
