//
//  WeatherDataSourse.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
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

protocol WeatherDataSourseProtocol {
    func set(forecastData:  [DayWeatherData])
    func reloadData()
}

protocol WeatherDataSourseDelegate: AnyObject {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}


final class WeatherDataSourse: NSObject {
    
    // - UI
    private unowned var tableView: UITableView
    
    // - Delegate
    private weak var delegate: WeatherDataSourseDelegate?
    
    // - Data
    private var forecastData: [DayWeatherData] = []
    
    // - Init
    init(tableView: UITableView, delegate: WeatherDataSourseDelegate) {
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        configure()
    }
    
}

// MARK: - WeatherDataSourseProtocol
extension WeatherDataSourse: WeatherDataSourseProtocol {
    
    func set(forecastData:  [DayWeatherData]) {
        self.forecastData = forecastData
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    
}

// MARK: - UITableViewDataSource
extension WeatherDataSourse: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        WeatherSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        false
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }

    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        indexPath
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch WeatherSectionType(rawValue: section) {
        case .forecast:
            return forecastData.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch WeatherSectionType(rawValue: indexPath.section) {
        case .forecast:
            return dayWeatherCell(cellForRowAt: indexPath)
        case .hourly:
            return hourlyWeatherCell(cellForRowAt: indexPath)
        case .additional:
            return additionalInformationCell(cellForRowAt: indexPath)
        case .none:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension WeatherDataSourse: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch WeatherSectionType(rawValue: section) {
        case .forecast, .hourly:
            return weatherSectionHeaderView(viewForHeaderInSection: section)
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch WeatherSectionType(rawValue: section) {
        case .forecast, .hourly:
            return 45
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

}

// MARK: - Header
private extension WeatherDataSourse {
    
    func weatherSectionHeaderView(viewForHeaderInSection section: Int) -> UIView? {
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: WeatherSectionHeader.reuseID) as? WeatherSectionHeader {
            let type = WeatherSectionType(rawValue: section)
            view.set(title: type?.title ?? "", image: type?.image)
            return view
        }
        return nil
    }
    
}

// MARK: - Cell
private extension WeatherDataSourse {
    
    func hourlyWeatherCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HourlyWeatherCell.reuseID, for: indexPath) as? HourlyWeatherCell {
            let mockData = [HourWeatherData(timestamp: "11",
                                            weatherType: .clouds,
                                            temperature: "26"),
                            HourWeatherData(timestamp: "12",
                                            weatherType: .clouds,
                                            temperature: "22"),
                            HourWeatherData(timestamp: "13",
                                            weatherType: .clouds,
                                            temperature: "22"),
                            HourWeatherData(timestamp: "14",
                                            weatherType: .clouds,
                                            temperature: "22"),
                            HourWeatherData(timestamp: "15",
                                            weatherType: .clouds,
                                            temperature: "22"),
                             HourWeatherData(timestamp: "16",
                                            weatherType: .clouds,
                                            temperature: "24"),
                             HourWeatherData(timestamp: "17",
                                            weatherType: .clouds,
                                            temperature: "24"),
                             HourWeatherData(timestamp: "18",
                                            weatherType: .clouds,
                                            temperature: "25"),
                             HourWeatherData(timestamp: "19",
                                            weatherType: .clouds,
                                            temperature: "26"),
                            HourWeatherData(timestamp: "20",
                                            weatherType: .clouds,
                                            temperature: "26")]
            cell.set(data: mockData)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func dayWeatherCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: DayWeatherCell.reuseID, for: indexPath) as? DayWeatherCell {
            let index = indexPath.row
            let data = forecastData[index]
            cell.set(data: data, isLast: index == forecastData.count - 1)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func additionalInformationCell(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AdditionalInformationCell.reuseID, for: indexPath) as? AdditionalInformationCell {
            return cell
        }
        
        return UITableViewCell()
    }
        
}

// MARK: - Configure
private extension WeatherDataSourse {
    
    func configure() {
        registerCells()
        setupDataSource()
        setupDataSource()
    }
    
    func setupDataSource() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = .init(top: 0, left: 0, bottom: 80, right: 0)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 9
        tableView.allowsSelection = false // TODO: 
    }
    
    func registerCells() {
        tableView.register(HourlyWeatherCell.self, forCellReuseIdentifier: HourlyWeatherCell.reuseID)
        tableView.register(DayWeatherCell.self, forCellReuseIdentifier: DayWeatherCell.reuseID)
        tableView.register(AdditionalInformationCell.self, forCellReuseIdentifier: AdditionalInformationCell.reuseID)
        tableView.register(WeatherSectionHeader.self, forHeaderFooterViewReuseIdentifier: WeatherSectionHeader.reuseID)
    }
    
}
