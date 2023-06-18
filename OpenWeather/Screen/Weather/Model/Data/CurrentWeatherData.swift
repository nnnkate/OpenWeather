//
//  CurrentWeatherData.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 18.06.23.
//

import Foundation

struct CurrentWeatherData {
    let cityName: String
    let condition: String
    let temperature: Int
    let minTemperature: Int
    let maxTemperature: Int
    let humidity: Int
    let visibility: Int
    let feelsLike: Int
    let wind: Int
    
    init(cityName: String = "",
         condition: String = "",
         temperature: Int = 0,
         minTemperature: Int = 0,
         maxTemperature: Int = 0,
         humidity: Int = 0,
         visibility: Int = 0,
         feelsLike: Int = 0,
         wind: Int = 0) {
        self.cityName = cityName
        self.condition = condition
        self.temperature = temperature
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.humidity = humidity
        self.visibility = visibility
        self.feelsLike = feelsLike
        self.wind = wind
    }
    
    static func convertFromDto(dto: CurrentWeatherResponse) -> CurrentWeatherData {
        let data = CurrentWeatherData(cityName: dto.name,
                                      condition: dto.weather.first?.main ?? "",
                                      temperature: Int(dto.main.temp),
                                      minTemperature: Int(dto.main.tempMin),
                                      maxTemperature: Int(dto.main.tempMax),
                                      humidity: Int(dto.main.humidity),
                                      visibility: dto.visibility / 1000,
                                      feelsLike: Int(dto.main.feelsLike),
                                      wind: Int(dto.wind.speed))
        return data
    }
    
    
    static func convertFromDb(realm: CurrentWeatherRealm) -> CurrentWeatherData {
        CurrentWeatherData(cityName: realm.cityName,
                           condition: realm.condition,
                           temperature: realm.temperature,
                           minTemperature: realm.minTemperature,
                           maxTemperature: realm.maxTemperature,
                           humidity: realm.humidity,
                           visibility: realm.visibility,
                           feelsLike: realm.feelsLike,
                           wind: realm.wind)
    }
}
