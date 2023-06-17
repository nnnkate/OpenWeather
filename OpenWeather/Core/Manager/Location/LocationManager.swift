//
//  LocationManager.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol {
    var location: CLLocation? { get }
    func requestLocation()
}

protocol LocationManagerDelegate: AnyObject {
    func locationDidUpdate(_ location: CLLocation?)
}

final class LocationManager: NSObject, LocationManagerProtocol {
    
    // - Data
    private lazy var manager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    private(set) var location: CLLocation? {
        didSet {
            delegate?.locationDidUpdate(location)
        }
    }
    
    // - Delegate
    private weak var delegate: LocationManagerDelegate?
    
    // - LifeCycle
    init(delegate: LocationManagerDelegate) {
        self.delegate = delegate
        super.init()
    }
    
}

// MARK: - Request
extension LocationManager {
    
    func requestLocation() {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        default:
            requestPermission()
        }
    }
    
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        requestLocation()
    }
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error.localizedDescription) // TODO: error handler
    }
    
}

