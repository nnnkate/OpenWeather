//
//  AdditionalInformationType.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 18.06.23.
//

import UIKit

enum AdditionalInformationType: Int, CaseIterable {
    case humidity
    case feelsLike
    case wind
    case visibility
}

extension AdditionalInformationType {
    
    var title: String {
        switch self {
        case .humidity:
            return "humidity_title".localized
        case .feelsLike:
            return "feels_like_title".localized
        case .wind:
            return "wind_title".localized
        case .visibility:
            return "visibility_title".localized
        }
    }
    
    var image: UIImage {
        switch self {
        case .humidity:
            return .init(systemName: "humidity") ?? .init()
        case .feelsLike:
            return .init(systemName: "thermometer.medium") ?? .init()
        case .wind:
            return .init(systemName: "wind") ?? .init()
        case .visibility:
            return .init(systemName: "eye.fill") ?? .init()
        }
    }
    
    var imageWidth: CGFloat {
        switch self {
        case .feelsLike:
            return 13
        default:
            return 16
        }
    }
    
    var mainView: UIView {
        switch self {
        case .wind:
            return WindTypeView()
        case .humidity:
            return HumidityTypeView()
        default:
            return UIView()
        }
    }
    
}
