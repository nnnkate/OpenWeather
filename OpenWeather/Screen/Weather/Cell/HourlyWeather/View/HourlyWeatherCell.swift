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
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    // - DataSource
    private lazy var currentWeatherDataSource: CurrentWeatherDataSourceProtocol = CurrentWeatherDataSource(collectionView: collectionView)
    
    // - Data
    private var data: [HourWeatherData] = []

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

// MARK: - Set
extension HourlyWeatherCell {
    
    func set(data: [HourWeatherData]) {
        currentWeatherDataSource.set(data: data)
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
        collectionView.backgroundColor = .clear
    }
    
    func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addBlur()
        mainView.addSubview(collectionView)
    }
    
    func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(85)
            $0.bottom.equalTo(-10)
        }
    }
    
}
