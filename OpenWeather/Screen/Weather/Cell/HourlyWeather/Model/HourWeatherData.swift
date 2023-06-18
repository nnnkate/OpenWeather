//
//  HourWeatherData.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 18.06.23.
//

import Foundation

struct HourWeatherData {
    let timestamp: String
    let weatherType: WeatherType?
    let temperature: String
    
    init(timestamp: String, weatherType: WeatherType?, temperature: String) {
        self.timestamp = timestamp
        self.weatherType = weatherType
        self.temperature = temperature
    }
}
