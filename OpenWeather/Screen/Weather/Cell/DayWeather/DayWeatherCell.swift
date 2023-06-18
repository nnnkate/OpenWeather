//
//  DayWeatherCell.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

final class DayWeatherCell: UITableViewCell {
    
    // - Register
    static let reuseID = "DayWeatherCell"
    
    // - UI
    private lazy var mainView = UIView()
    private lazy var separator = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    private lazy var stackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalCentering
        return view
    }()
    private lazy var dayLabel = Label(font: UIFont(name: "Inter-Medium", size: 18))
    private lazy var conditionImageView = {
        let view = UIImageView()
        view.tintColor = .white
        return view
    }()
    private lazy var conditionLabel = Label(color: .blue, font: UIFont(name: "Inter-Medium", size: 11))
    private lazy var minTemperatureLabel = Label(color: .gray, font: UIFont(name: "Inter-Medium", size: 16))
    private lazy var maxTemperatureLabel = Label(font: UIFont(name: "Inter-Medium", size: 16))
    
    // - Data
    private(set) var data: DayWeatherData?
    private(set) var isLast = false

    // - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        mainView.roundCorners(topLeft: 0, topRight: 0, bottomLeft: isLast ? 14 : 0, bottomRight: isLast ? 14 : 0)
    }
        
}

// MARK: - Set
extension DayWeatherCell {
    
    func set(data: DayWeatherData, isLast: Bool) {
        self.data = data
        self.isLast = isLast
        updateData()
    }
    
}

// MARK: - Update
private extension DayWeatherCell {
    
    func updateData() {
        guard let data else {
            dayLabel.text = ""
            conditionImageView.image = UIImage()
            minTemperatureLabel.text = ""
            maxTemperatureLabel.text = ""
            return
        }
        dayLabel.text = data.date.standartDate?.getWeekday()
        let weatherType = data.weatherType
        conditionImageView.image = weatherType?.image
        conditionLabel.isHidden = weatherType != .snow && weatherType != .rain
        conditionLabel.text = weatherType == .snow ? "70 %" : "" // TODO:
        minTemperatureLabel.text = "\(String(data.minTemperature))°"
        maxTemperatureLabel.text =  "\(String(data.maxTemperature))°"
    }
    
}

// MARK: - Configure
private extension DayWeatherCell {
    
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
        mainView.addBlur()
        mainView.addSubview(stackView)
        mainView.addSubview(separator)
        stackView.addArrangedSubview(dayLabel)
        stackView.addArrangedSubview(conditionImageView)
        stackView.addArrangedSubview(conditionLabel)
        stackView.addArrangedSubview(minTemperatureLabel)
        stackView.addArrangedSubview(maxTemperatureLabel)
    }
    
    func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.leading.equalTo(14)
            $0.trailing.bottom.equalTo(-14)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(14)
            $0.trailing.equalTo(-14)
            $0.height.equalTo(0.5)
        }
    }
    
}


