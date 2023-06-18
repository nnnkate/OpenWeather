//
//  WeatherSectionType.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 18.06.23.
//

import UIKit

enum WeatherSectionType: Int, CaseIterable {
    case hourly
    case forecast
    case additional
}

extension WeatherSectionType {
    
    var title: String {
        switch self {
        case .forecast:
            return "forecast_section_title".localized
        case .hourly:
            return "hourly_section_title".localized
        default:
            return ""
        }
    }
    
    var image: UIImage {
        switch self {
        case .forecast:
            return .init(systemName: "calendar") ?? .init()
        case .hourly:
            return .init(systemName: "clock") ?? .init()
        default:
            return .init()
        }
    }
    
}
