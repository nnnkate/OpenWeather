//
//  WeatherDatabaseManager.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 18.06.23.
//

import Foundation
import RealmSwift

final class CurrentWeatherDatabaseManager: BaseDatabaseManager<CurrentWeatherRealm> {
    
    override func areTheSameItems(_ first: CurrentWeatherRealm, _ second: CurrentWeatherRealm) -> Bool {
        true
    }

}

final class DayWeatherDatabaseManager: BaseDatabaseManager<DayWeatherRealm> {
    
    override func areTheSameItems(_ first: DayWeatherRealm, _ second: DayWeatherRealm) -> Bool {
        true
    }

}

