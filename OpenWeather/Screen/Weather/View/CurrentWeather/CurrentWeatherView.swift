//
//  CurrentWeatherView.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

final class CurrentWeatherView: UIView {
    
    // - UI
    private lazy var mainView = UIView()
    private lazy var stackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.contentMode = .center
        return view
    }()
    private lazy var cityLabel = Label(font: .systemFont(ofSize: 30), textAlignment: .center)
    private lazy var temperatureLabel = Label(font: .systemFont(ofSize: PhoneSize.type == .small ? 60 : 90, weight: .thin), textAlignment: .center)
    private lazy var conditionLabel = Label(font: UIFont(name: "Inter-Medium", size: 20), textAlignment: .center)
    private lazy var minMaxTemperatureLabel = Label(font: UIFont(name: "Inter-Medium", size: 17), textAlignment: .center)
   
    
    // - Data
    private(set) var data: CurrentWeatherData?
    private let spacing: CGFloat = PhoneSize.type == .small ? 30 : 60
    private let maxInset: CGFloat = 80
    private let minInset: CGFloat = 40
    private lazy var height: CGFloat = PhoneSize.type == .small ? 220 : 280

    // - LifeCycle
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
}

// MARK: - Set
extension CurrentWeatherView {
    
    func set(data: CurrentWeatherData) {
        self.data = data
        updateData()
    }
    
    func set(inset: CGFloat) {
        let inset = inset > minInset ? minInset : abs(inset)
        mainView.snp.updateConstraints {
            $0.height.equalTo(height - ((inset < maxInset) ? (inset) : (maxInset)))
        }
        stackView.snp.updateConstraints {
            $0.top.equalTo(spacing - (inset > maxInset ? maxInset : inset))
        }
        changeVisibility(label: minMaxTemperatureLabel, maxY: minMaxTemperatureLabel.frame.maxY, frameMaxY: mainView.frame.maxY)
        changeVisibility(label: conditionLabel, maxY: conditionLabel.frame.maxY, frameMaxY: mainView.frame.maxY)
    }
    
}

// MARK: - Helper
private extension CurrentWeatherView {
    
    func changeVisibility(label: UILabel, maxY: CGFloat, frameMaxY: CGFloat) {
        let inset: CGFloat = frameMaxY - maxY
        if inset < maxInset {
            if inset < spacing {
                minMaxTemperatureLabel.alpha = 0
            } else {
                minMaxTemperatureLabel.alpha = abs(spacing - inset) / (spacing - (inset > minInset ? minInset : inset))
            }
        } else {
            minMaxTemperatureLabel.alpha = 1
        }
    }
    
}

// MARK: - Update
private extension CurrentWeatherView {
    
    func updateData() {
        guard let data else {
            cityLabel.text = ""
            temperatureLabel.text = "--"
            conditionLabel.text = ""
            minMaxTemperatureLabel.text = ""
            return
        }
        cityLabel.text = data.cityName
        let temperature = data.temperature
        temperatureLabel.text = "\(temperature)°"
        conditionLabel.text = data.condition
        minMaxTemperatureLabel.text = "H:\(data.maxTemperature)°  L:\(data.minTemperature)°"
    }
    
}

// MARK: - Configure
private extension CurrentWeatherView {
    
    func configure() {
        configureUI()
        addSubviews()
        makeConstraints()
    }
    
    func configureUI() {
        backgroundColor = .clear
    }
    
    func addSubviews() {
        addSubview(mainView)
        mainView.addSubview(stackView)
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(temperatureLabel)
        stackView.addArrangedSubview(conditionLabel)
        stackView.addArrangedSubview(minMaxTemperatureLabel)
    }
    
    func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(height)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(spacing)
//            $0.bottom.equalTo(-spacing).priority(999)
            $0.leading.greaterThanOrEqualTo(14).priority(999)
            $0.trailing.lessThanOrEqualTo(-14).priority(999)
        }
    }
    
}



