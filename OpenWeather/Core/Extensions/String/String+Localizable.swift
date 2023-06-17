//
//  String+Localizable.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
}
