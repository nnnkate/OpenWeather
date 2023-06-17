//
//  HourlyWeatherCell.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

final class HourlyWeatherCell: UITableViewCell {
    
    // - Register
    static let reuseID = "HourlyWeatherCell"
    
    // - UI
    private lazy var mainView = UIView()

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
        mainView.roundCorners(topLeft: 0, topRight: 0, bottomLeft: 14, bottomRight: 14)
    }
        
}

// MARK: - Configure
private extension HourlyWeatherCell {
    
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
    }
    
    func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
}



