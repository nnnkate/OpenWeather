//
//  WeatherSectionHeaderView.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

final class WeatherSectionHeaderView: UITableViewHeaderFooterView {
    
    // - Register
    static let reuseID = "WeatherSectionHeaderView"
        
    // - UI
    private lazy var mainView = WeatherSectionView()
    
    // - LifeCycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        mainView.roundCorners(topLeft: 14, topRight: 14, bottomLeft: 0, bottomRight: 0)
    }
    
}

// MARK: - Set
extension WeatherSectionHeaderView {
    
    func set(title: String, image: UIImage?) {
        mainView.set(title: title, image: image)
    }
    
}

// MARK: - Configure
private extension WeatherSectionHeaderView {
    
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
    }
    
    func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}


