//
//  CurrentWeatherType.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

enum CurrentWeatherType: String {
    case cloudsSunset
    case clouds
    case sun
    case night
}

extension CurrentWeatherType {
    var image: UIImage? {
        switch self {
        case .cloudsSunset:
            return UIImage(named: "clouds_sunset")
        case .clouds:
            return UIImage(named: "clouds_day")
        case .sun:
            return UIImage(named: "sun")
        case .night:
            return UIImage(named: "night")
        }
    }
}
