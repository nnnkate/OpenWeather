//
//  WeatherType.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

enum WeatherType: String {
    case clouds
    case snow
}

extension WeatherType {
    var image: UIImage? {
        switch self {
        case .clouds:
            return UIImage(named: "clouds")
        case .snow:
            return UIImage(named: "snow")
        }
    }
}
