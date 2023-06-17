//
//  ViewController.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    
    // - UI
    private lazy var backgroundImageView = UIImageView(image: CurrentWeatherType.sun.image)
    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
    private lazy var bottomView = WeatherBottomView()
    
    // - DataSource
    private lazy var dataSource: WeatherDataSourseProtocol = WeatherDataSourse(tableView: tableView)
    
    // - Presenter
    private lazy var presenter: WeatherPresenterProtocol = WeatherPresenter(delegate: self)

    // - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

// MARK: - Reload
private extension WeatherViewController {
    
    func updateSeveralDaysData(_ data: [DayWeatherData]) {
        dataSource.set(forecastData: data)
        dataSource.reloadData() // TODO: add several methods (for sections)
    }
    
    func updateData() {
        backgroundImageView.image = CurrentWeatherType.night.image // TODO:
        dataSource.reloadData() // TODO: add several methods (for sections)
    }
    
}

// MARK: - WeatherPresenterDelegate
extension WeatherViewController: WeatherPresenterDelegate {
    
    func updateCurrentWeather(_ data: CurrentWeatherResponse) {
        updateData()
    }
    
    func updateSeveralDaysWeather(_ data: [DayWeatherData]) {
        updateSeveralDaysData(data)
    }
    
}

// MARK: - Configure
private extension WeatherViewController {
    
    func configure() {
        addSubviews()
        makeConstraints()
        configureUI()
        configurePresenter()
    }
    
    func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(tableView)
        view.addSubview(bottomView)
    }
    
    func makeConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(72)
        }
    }
    
    func configureUI() {
        tableView.backgroundColor = .clear
    }
    
    func configurePresenter() {
        presenter.requestLocation()
    }
       
}

