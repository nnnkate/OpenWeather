//
//  NetworkManager.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import Foundation
import CoreLocation

protocol NetworkManagerProtocol {
    func loadCurrentWeather(latitude: CLLocationDegrees,
                           longitude: CLLocationDegrees,
                           completion: @escaping (CurrentWeatherResponse?, Error?) -> ())
    func loadSeveralDaysWeather(latitude: CLLocationDegrees,
                               longitude: CLLocationDegrees,
                               completion: @escaping (SeveralDaysWeather?, Error?) -> ())
}

final class NetworkManager {
    
    //  - Data
    private let appID = Constant.appID
    private let baseURL = Constant.baseURL
    
}

// MARK: - Fetch
extension NetworkManager {
    
    private func fetchData(urlString: String,
                           completion: @escaping (Data?, Error?) -> ()) {
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL)
            completion(nil, error)
            return
        }

        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                    return
                }
                guard let data = data else { return }
                completion(data, nil)
            }
        }
        dataTask.resume()
    }
    
}

// MARK: - API
extension NetworkManager: NetworkManagerProtocol {
    
    func loadCurrentWeather(latitude: CLLocationDegrees,
                            longitude: CLLocationDegrees,
                            completion: @escaping (CurrentWeatherResponse?, Error?) -> ()) {
        let urlString = "\(baseURL)weather?lat=\(latitude)&lon=\(longitude)&appid=\(appID)&units=metric"
        fetchData(urlString: urlString) { data, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let weatherResponse = try decoder.decode(CurrentWeatherResponse.self, from: data)
                completion(weatherResponse, nil)
            }
            catch let error {
                completion(nil, error)
            }
        }
    }
    
    func loadSeveralDaysWeather(latitude: CLLocationDegrees,
                                longitude: CLLocationDegrees,
                                completion: @escaping (SeveralDaysWeather?, Error?) -> ()) {
        let urlString = "\(baseURL)forecast?lat=\(latitude)&lon=\(longitude)&appid=\(appID)&units=metric"
        fetchData(urlString: urlString) { data, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let severalDaysWeatherResponse = try decoder.decode(SeveralDaysWeatherResponse.self, from: data)
                let severalDaysWeather = SeveralDaysWeather(response: severalDaysWeatherResponse)
                completion(severalDaysWeather, nil)
            }
            catch let error {
                completion(nil, error)
            }
        }
    }
    
}



