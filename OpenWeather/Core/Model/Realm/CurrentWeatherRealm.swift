//
//  CurrentWeatherRealm.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 18.06.23.
//

import Foundation
import RealmSwift

final class CurrentWeatherRealm: Object {
    @Persisted(primaryKey: true) var primarykeyId: String = UUID().uuidString
    @Persisted private(set) var cityName: String
    @Persisted private(set) var condition: String
    @Persisted private(set) var temperature: Int
    @Persisted private(set) var minTemperature: Int
    @Persisted private(set) var maxTemperature: Int
    @Persisted private(set) var visibility: Int
    @Persisted private(set) var wind: Int
   
    static func convertFromDto(dto: CurrentWeatherData) -> CurrentWeatherRealm {
        let realm = CurrentWeatherRealm()
        realm.cityName = dto.cityName
        realm.condition = dto.condition
        realm.temperature = dto.temperature
        realm.minTemperature = dto.minTemperature
        realm.maxTemperature = dto.maxTemperature
        realm.visibility = dto.visibility
        realm.wind = dto.wind
        return realm
    }
}

