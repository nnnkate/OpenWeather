//
//  Response.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import Foundation

struct SeveralDaysWeatherResponse: Decodable {
    var list: [DayData]
}

struct SeveralDaysWeather: Decodable {
    var list = [DayData]()

    init(response: SeveralDaysWeatherResponse) {
        var dateString = ""
        var currentIndex = 0
        
        for element in response.list {
            let currentDateString = element.date.prefix(11)
            if dateString != currentDateString {
                dateString = String(currentDateString)
            
                list.append(DayData(main: element.main, weather: element.weather, date: dateString))
                currentIndex += 1
            } else {
                var currentDayDataMain = list[currentIndex-1].main
                
                let mainResponse = element.main
                
                if mainResponse.tempMin < currentDayDataMain.tempMin {
                    currentDayDataMain.changeTempMin(newValue: mainResponse.tempMin)
                }
                
                if mainResponse.tempMax > currentDayDataMain.tempMax {
                    currentDayDataMain.changeTempMax(newValue: mainResponse.tempMax)
                }
                list[currentIndex-1].main = currentDayDataMain
            }
        }
    }
}

struct DayData: Decodable {
    var main: MainResponse
    var weather: [Weather]
    var date: String
    
    private enum CodingKeys: String, CodingKey {
        case main
        case weather
        case date = "dt_txt"
    }
}

struct SearchWeatherResponse: Decodable {
    var list: [CurrentWeatherResponse]
}

struct CurrentWeatherResponse: Decodable {
    var coord: CoordinatesResponse
    var weather: [Weather]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    var visibility: Int
}

struct CoordinatesResponse: Decodable {
    var lon: Double
    var lat: Double
}

struct Weather: Decodable {
    var id: Double
    var main: String
    var description: String
    var icon: String
}

struct MainResponse: Decodable {
    var temp: Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    var humidity: Double
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
    
    mutating func changeTempMin(newValue: Double) {
        tempMin = newValue
    }
    
    mutating func changeTempMax(newValue: Double) {
        tempMax = newValue
    }
}

struct WindResponse: Decodable {
    var speed: Double
    var deg: Double
}


