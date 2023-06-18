//
//  WeatherType.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit
import RealmSwift

enum WeatherType: String, PersistableEnum {
    case clouds
    case snow
    case rain
}

extension WeatherType {
    var image: UIImage? {
        switch self {
        case .clouds:
            return UIImage(named: "clouds")
        case .snow:
            return UIImage(named: "snow")
        case .rain:
            return UIImage(named: "rain")
        }
    }
}
