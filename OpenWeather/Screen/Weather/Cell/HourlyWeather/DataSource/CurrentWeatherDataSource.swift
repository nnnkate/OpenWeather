//
//  CurrentWeatherDataSource.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 18.06.23.
//

import UIKit

protocol CurrentWeatherDataSourceProtocol {
    func update()
    func set(data: [HourWeatherData])
}

final class CurrentWeatherDataSource: NSObject {
    
    // - UI
    private unowned let collectionView: UICollectionView
    
    // - Data
    private var data: [HourWeatherData] = []
    private let inset: CGFloat = 14
    
    // - LifeCycle
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        configure()
    }
    
}

// MARK: - CurrentWeatherDataSourceProtocol
extension CurrentWeatherDataSource: CurrentWeatherDataSourceProtocol {
    
    func set(data: [HourWeatherData]) {
        self.data = data
        update()
    }
    
    func update() {
        collectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource
extension CurrentWeatherDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourWeatherCell.reuseID, for: indexPath) as! HourWeatherCell
        cell.set(data: data[indexPath.row])
        return cell
    }
    
}

// MARK: - Layout
extension CurrentWeatherDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 50, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
    
}

// MARK: - Configure
private extension CurrentWeatherDataSource {
    
    func configure() {
        configureCollectionViewLayout()
        setupDataSource()
        registerCells()
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.invalidateLayout()
        collectionView.collectionViewLayout = layout
    }
    
    func setupDataSource() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func registerCells() {
        collectionView.register(HourWeatherCell.self, forCellWithReuseIdentifier: HourWeatherCell.reuseID)
    }
    
}
