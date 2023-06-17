//
//  PhoneSize.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

enum PhoneSize: Int {
    case small
    case medium
    case large
    case extraLarge
    
    static var type: PhoneSize {
        let height = Int(UIScreen.main.bounds.size.height)
        let width = Int(UIScreen.main.bounds.size.width)
        switch height {
        case ...667:
            return .small
        case 668...853:
            return .medium
        case 813...900:
            return .large
        case 900...:
            return .extraLarge
        default:
            return .large
        }
    }
    
}

