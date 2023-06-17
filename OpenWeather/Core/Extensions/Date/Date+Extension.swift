//
//  Date+Extension.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import Foundation

extension Date {
    
    func getWeekday() -> String {
        let calendar = Calendar.current
        let currentDate = calendar.startOfDay(for: Date())
        if self == currentDate {
            return "today".localized
        }
        return WeekDay(rawValue: calendar.component(.weekday, from: self))?.shortName ?? ""
    }
    
}
