//
//  WeatherBottomView.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

final class WeatherBottomView: UIView {
    
    // - UI
    private lazy var mapImageView = {
        let view = UIImageView(image: UIImage(systemName: "map"))
        view.tintColor = .white
        return view
    }()
    private lazy var locationImageView = UIImageView(image: UIImage(named: "location"))
    private lazy var listImageView = {
        let view = UIImageView(image: UIImage(systemName: "list.bullet"))
        view.tintColor = .white
        return view
    }()
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
        addBlur(alpha: 0.98)
        addSubview(mapImageView)
        addSubview(locationImageView)
        addSubview(listImageView)
        addSubview(separator)
    }
    
    func makeConstraints() {
        mapImageView.snp.makeConstraints {
            $0.top.equalTo(8)
            $0.leading.equalTo(20)
            $0.height.width.equalTo(23)
        }
        
        listImageView.snp.makeConstraints {
            $0.top.equalTo(8)
            $0.trailing.equalTo(-20)
            $0.height.width.equalTo(23)
        }
        
        locationImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(16)
            $0.height.equalTo(13)
            $0.width.equalTo(33)
        }
        
        separator.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
}
