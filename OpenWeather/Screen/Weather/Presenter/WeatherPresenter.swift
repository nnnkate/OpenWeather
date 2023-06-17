//
//  WeatherPresenter.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import Foundation
import CoreLocation

protocol WeatherPresenterDelegate: AnyObject {
    func updateCurrentWeather(_ data: CurrentWeatherResponse)
    func updateSeveralDaysWeather(_ data: [DayWeatherData])
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
        loadCurrentWeather()
        loadSeveralDaysWeather()
    }
    
}

// MARK: - WeatherPresenterProtocol
extension WeatherPresenter: WeatherPresenterProtocol {

    func requestLocation() {
        locationManager.requestLocation()
    }

}

// MARK: - Load
private extension WeatherPresenter {
    
    func loadCurrentWeather() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        networkManager.loadCurrentWeather(latitude: coordinate.latitude,
                                          longitude: coordinate.longitude) { [weak self] data, error in
            if let error = error {
                debugPrint(error) // TODO: error handler
            }
            guard let self, let data else { return }
            self.delegate?.updateCurrentWeather(data)
        }
    }
    
    func loadSeveralDaysWeather() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        networkManager.loadSeveralDaysWeather(latitude: coordinate.latitude,
                                              longitude: coordinate.longitude) { [weak self] data, error in
            if let error = error {
                debugPrint(error) // TODO: error handler
            }
            guard let self, let data else { return }
            self.delegate?.updateSeveralDaysWeather(data.list.map { DayWeatherData.convertFromDto(dto: $0) })
        }
    }
    
}

// MARK: - Configure
private extension WeatherPresenter {
    
    func configure() {

    }
    
}
