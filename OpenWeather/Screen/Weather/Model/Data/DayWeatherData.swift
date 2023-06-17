//
//  DayWeatherData.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

struct DayWeatherData {
    let date: String
    let minTemperature: Int
    let maxTemperature: Int
    let weatherType: WeatherType?
    
    static func convertFromDto(dto: DayData?) -> DayWeatherData {
        let data = DayWeatherData(date: dto?.date ?? "",
                                  minTemperature: Int(dto?.main.tempMin ?? 0),
                                  maxTemperature: Int(dto?.main.tempMax ?? 0),
                                  weatherType: WeatherType(rawValue: "clouds") ?? .clouds) // TODO: ADD
        return data
    }
}


