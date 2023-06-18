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
    let visibility: Int
    let wind: Int
    
    init(cityName: String = "",
         condition: String = "",
         temperature: Int = 0,
         minTemperature: Int = 0,
         maxTemperature: Int = 0,
         visibility: Int = 0,
         wind: Int = 0) {
        self.cityName = cityName
        self.condition = condition
        self.temperature = temperature
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.visibility = visibility
        self.wind = wind
    }
    
    static func convertFromDto(dto: CurrentWeatherResponse) -> CurrentWeatherData {
        let data = CurrentWeatherData(cityName: dto.name,
                                      condition: dto.weather.first?.main ?? "",
                                      temperature: Int(dto.main.temp),
                                      minTemperature: Int(dto.main.tempMin),
                                      maxTemperature: Int(dto.main.tempMax),
                                      visibility: dto.visibility / 1000,
                                      wind: Int(dto.wind.speed))
        return data
    }
    
    
    static func convertFromDb(realm: CurrentWeatherRealm) -> CurrentWeatherData {
        CurrentWeatherData(cityName: realm.cityName,
                           condition: realm.condition,
                           temperature: realm.temperature,
                           minTemperature: realm.minTemperature,
                           maxTemperature: realm.maxTemperature,
                           visibility: realm.visibility,
                           wind: realm.wind)
    }
}
