//
//  WeatherPresenter.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import Foundation
import CoreLocation

protocol WeatherPresenterDelegate: AnyObject {
    func updateCurrentWeather(_ data: CurrentWeatherData)
    func updateSeveralDaysWeather(_ data: [DayWeatherData])
    func updateData()
}

protocol WeatherPresenterProtocol {
    func requestLocation()
}

final class WeatherPresenter {
    
    // - Data
    private lazy var locationManager: LocationManagerProtocol = LocationManager(delegate: self)
    private lazy var networkManager: NetworkManagerProtocol = NetworkManager()
    
    // - Delegate
    private weak var delegate: WeatherPresenterDelegate?
    
    // - LifeCycle
    init(delegate: WeatherPresenterDelegate?) {
        self.delegate = delegate
        configure()
    }
    
}

// MARK: - LocationManagerDelegate
extension WeatherPresenter: LocationManagerDelegate {
    
    func locationDidUpdate(_ location: CLLocation?) {
        loadData()
    }
    
}

// MARK: - WeatherPresenterProtocol
extension WeatherPresenter: WeatherPresenterProtocol {

    func requestLocation() {
        locationManager.requestLocation()
    }

}

// MARK: - Update
private extension WeatherPresenter {

    func updateCurrentWeather() {
        if let item = CurrentWeatherDatabaseManager().items.first {
            delegate?.updateCurrentWeather(CurrentWeatherData.convertFromDb(realm: item))
            return
        }
        delegate?.updateCurrentWeather(CurrentWeatherData())
    }
   
    func updateSeveralDaysWeather() {
        let items = DayWeatherDatabaseManager().items
        delegate?.updateSeveralDaysWeather(items.map { DayWeatherData.convertFromDb(realm: $0) })
    }
    
}

// MARK: - Load
private extension WeatherPresenter {
    
    func loadData() {
        let queue = DispatchQueue(label: "LoadData")
        let group = DispatchGroup()
        group.enter()
        queue.async(group: group) { [weak self] in
            self?.loadCurrentWeather {
                self?.updateCurrentWeather()
                group.leave()
            }
        }
        queue.async(group: group) { [weak self] in
            self?.loadSeveralDaysWeather {
                self?.updateSeveralDaysWeather()
                group.leave()
            }
        }
        group.notify(queue: queue) {
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.updateData()
            }
        }
               
    }
    
    func loadCurrentWeather(completion: @escaping () -> ()) {
        guard let coordinate = locationManager.location?.coordinate else { return }
        networkManager.loadCurrentWeather(latitude: coordinate.latitude,
                                          longitude: coordinate.longitude) { data, error in
            if let error = error {
                debugPrint(error)
            }
            guard let data else { return }
            let dto = CurrentWeatherData.convertFromDto(dto: data)
            let weatherRealm = CurrentWeatherRealm.convertFromDto(dto: dto)
            CurrentWeatherDatabaseManager().rewrite([weatherRealm])
            completion()
        }
    }
    
    func loadSeveralDaysWeather(completion: @escaping () -> ()) {
        guard let coordinate = locationManager.location?.coordinate else { return }
        networkManager.loadSeveralDaysWeather(latitude: coordinate.latitude,
                                              longitude: coordinate.longitude) { [weak self] data, error in
            if let error = error {
                debugPrint(error)
            }
            guard let self, let data else { return }
            self.updateSeveralDaysWeather()
            let dto = data.list.map { DayWeatherData.convertFromDto(dto: $0) }
            let weatherRealm = dto.map { DayWeatherRealm.convertFromDto(dto: $0) }
            DayWeatherDatabaseManager().rewrite(weatherRealm)
            self.updateSeveralDaysWeather()
        }
    }
    
}

// MARK: - Configure
private extension WeatherPresenter {
    
    func configure() {
        updateCurrentWeather()
        updateSeveralDaysWeather()
    }
    
}
