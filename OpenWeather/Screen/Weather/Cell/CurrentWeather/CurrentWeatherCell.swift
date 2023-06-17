//
//  CurrentWeatherCell.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

final class CurrentWeatherCell: UITableViewCell {
    
    // - Register
    static let reuseID = "CurrentWeatherCell"
    
    // - UI
    private lazy var mainView = UIView()
    private lazy var stackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.contentMode = .center
        return view
    }()
    private lazy var cityLabel = Label(font: UIFont(name: "Inter-Medium", size: 30), textAlignment: .center)
    private lazy var temperatureLabel = Label(font: UIFont(name: "Inter-Medium", size: 60), textAlignment: .center)
    private lazy var conditionLabel = Label(font: UIFont(name: "Inter-Medium", size: 20), textAlignment: .center)
    private lazy var minMaxTemperatureLabel = Label(font: UIFont(name: "Inter-Medium", size: 17), textAlignment: .center)
   
    
    // - Data
    private(set) var data: DayWeatherData?

    // - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
}

// MARK: - Set
extension CurrentWeatherCell {
    
    func set(data: DayWeatherData) {
        self.data = data
        updateData()
    }
    
}

// MARK: - Update
private extension CurrentWeatherCell {
    
    func updateData() {
        guard let data else {
            cityLabel.text = ""
            temperatureLabel.text = "--"
            conditionLabel.text = ""
            minMaxTemperatureLabel.text = ""
            return
        }
        cityLabel.text = "Minsk"
        temperatureLabel.text = "25-"
        conditionLabel.text = "Part Clo"
        minMaxTemperatureLabel.text = "J:58-"
    }
    
}

// MARK: - Configure
private extension CurrentWeatherCell {
    
    func configure() {
        configureUI()
        addSubviews()
        makeConstraints()
    }
    
    func configureUI() {
        backgroundColor = .clear
    }
    
    func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(stackView)
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(conditionLabel)
        stackView.addArrangedSubview(minMaxTemperatureLabel)
    }
    
    func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(PhoneSize.type == .small ? 30 : 70)
            $0.bottom.equalTo(PhoneSize.type == .small ? -30 : -70)
            $0.leading.greaterThanOrEqualTo(14).priority(999)
            $0.trailing.lessThanOrEqualTo(-14).priority(999)
        }
    }
    
}



