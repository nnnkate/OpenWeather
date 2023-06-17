//
//  WeekDay.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import Foundation

enum WeekDay: Int, CaseIterable {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7

    static func getDays(from startDay: WeekDay) -> [WeekDay] {
        let allDays = WeekDay.allCases
        let startIndex = allDays.firstIndex(of: startDay) ?? 0
        let rotatedDays = allDays.dropFirst(startIndex) + allDays.prefix(upTo: startIndex)
        return Array(rotatedDays)
    }
    
    static func getToday() -> WeekDay? {
        let index = Calendar.current.component(.weekday, from: Date())
        return allCases.first(where: { $0.rawValue == index })
    }
}

extension WeekDay {
    
    var name: String {
        switch self {
        case .sunday:
            return "sunday".localized
        case .monday:
            return "monday".localized
        case .tuesday:
            return "tuesday".localized
        case .wednesday:
            return "wednesday".localized
        case .thursday:
            return "thursday".localized
        case .friday:
            return "friday".localized
        case .saturday:
            return "saturday".localized
        }
    }
    
    var shortName: String {
        switch self {
        case .sunday:
            return "sunday_short".localized
        case .monday:
            return "monday_short".localized
        case .tuesday:
            return "tuesday_short".localized
        case .wednesday:
            return "wednesday_short".localized
        case .thursday:
            return "thursday_short".localized
        case .friday:
            return "friday_short".localized
        case .saturday:
            return "saturday_short".localized
        }
    }
    
}

