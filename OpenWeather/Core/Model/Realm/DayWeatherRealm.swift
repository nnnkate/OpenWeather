//
//  DayWeatherRealm.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 18.06.23.
//

import Foundation
import RealmSwift

final class DayWeatherRealm: Object {
    @Persisted(primaryKey: true) var primarykeyId: String = UUID().uuidString
    @Persisted private(set) var date: String
    @Persisted private(set) var minTemperature: Int
    @Persisted private(set) var maxTemperature: Int
    @Persisted private(set) var weatherType: WeatherType?
    
    static func convertFromDto(dto: DayWeatherData) -> DayWeatherRealm {
        let realm = DayWeatherRealm()
        realm.date = dto.date
        realm.minTemperature = dto.minTemperature
        realm.maxTemperature = dto.maxTemperature
        realm.weatherType = dto.weatherType
        return realm
    }
}
