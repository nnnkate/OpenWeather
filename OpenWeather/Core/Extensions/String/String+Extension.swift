//
//  String+Extension.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import Foundation

extension String {
    
    var standartDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // TODO: check "dd.MM.yyyy"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
    
}

