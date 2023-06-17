//
//  WeatherBottomView.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

final class WeatherBottomView: UIView {
    
    // - UI
    private lazy var separator = UIView()
    
    // - Data
    private var locations: [String] = []

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
extension WeatherBottomView {
    
    func set(locations: [String]) { // TODO: ADD LOCATIONS
        self.locations = locations
    }
    
}

// MARK: - Configure
private extension WeatherBottomView {
    
    func configure() {
        configureUI()
        addSubviews()
        makeConstraints()
    }
    
    func configureUI() {
      
    }
    
    func addSubviews() {
        addBlur()
        addSubview(separator)
    }
    
    func makeConstraints() {
        separator.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
}
