//
//  HourWeatherCell.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

final class HourWeatherCell: UICollectionViewCell {
    
    // - UI
    private lazy var hourLabel = Label(font: UIFont(name: "Inter-Medium", size: 14), textAlignment: .center)
    private lazy var conditionImageView = {
        let view = UIImageView()
        view.tintColor = .white
        return view
    }()
    private lazy var temperatureLabel = Label(font: UIFont(name: "Inter-Medium", size: 16), textAlignment: .center)
        
    // - Register
    static let reuseID = "HourWeatherCell"
    
    // - Data
    private(set) var data: HourWeatherData?

    // - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

}

// MARK: - Set
extension HourWeatherCell {
    
    func set(data: HourWeatherData) {
        self.data = data
        updateData()
    }
    
}

// MARK: - Update
private extension HourWeatherCell {
    
    func updateData() {
        guard let data else {
            hourLabel.text = ""
            conditionImageView.image = UIImage()
            temperatureLabel.text = ""
            return
        }
        let timestamp = Int(data.timestamp)
        let currentDateHour = Calendar.current.component(.hour, from: Date())
        hourLabel.text = timestamp == currentDateHour ?  "now".localized : data.timestamp
        let weatherType = data.weatherType
        conditionImageView.image = weatherType?.image
        temperatureLabel.text = data.temperature
    }
    
}

// MARK: - Configure
private extension HourWeatherCell {
    
    func configure() {
        configureUI()
        addSubviews()
        makeConstraints() 
    }
    
    func configureUI() {
       
    }
    
    func addSubviews() {
        contentView.addSubview(hourLabel)
        contentView.addSubview(conditionImageView)
        contentView.addSubview(temperatureLabel)
    }
    
    func makeConstraints() {
        hourLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(conditionImageView.snp.top)
        }
        
        conditionImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(28)
            $0.bottom.equalTo(temperatureLabel.snp.top).offset(-5)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
}

