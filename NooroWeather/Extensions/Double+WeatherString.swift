//
//  Double+WeatherString.swift
//  NooroWeather
//
//  Created by Kevin Sullivan on 1/25/25.
//

import Foundation

extension Double {
    func toFahrenheitString() -> String {
        let measuremant = Measurement<UnitTemperature>(value: self.rounded(), unit: .fahrenheit)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .temperatureWithoutUnit
        return formatter.string(from: measuremant)
    }
}
