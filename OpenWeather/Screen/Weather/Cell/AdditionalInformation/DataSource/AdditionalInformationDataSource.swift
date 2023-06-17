//
//  AdditionalInformationDataSource.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

enum AdditionalInformationType: Int, CaseIterable {
    case humidity
    case feelsLike
    case wind
    case visibility
}

extension AdditionalInformationType {
    
    var title: String {
        switch self {
        case .humidity:
            return "humidity_title".localized
        case .feelsLike:
            return "feels_like_title".localized
        case .wind:
            return "wind_title".localized
        case .visibility:
            return "visibility_title".localized
        }
    }
    
    var image: UIImage {
        switch self {
        case .humidity:
            return .init(systemName: "humidity") ?? .init()
        case .feelsLike:
            return .init(systemName: "thermometer.medium") ?? .init()
        case .wind:
            return .init(systemName: "wind") ?? .init()
        case .visibility:
            return .init(systemName: "eye.fill") ?? .init()
        }
    }
    
    var imageWidth: CGFloat {
        switch self {
        case .feelsLike:
            return 13
        default:
            return 16
        }
    }
    
}

protocol AdditionalInformationDataSourceProtocol {
    func update()
}

final class AdditionalInformationDataSource: NSObject {
    
    // - UI
    private unowned var collectionView: UICollectionView
    
    // - Data
    private let inset: CGFloat = 9
    
    // - LifeCycle
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        configure()
    }
    
}

// MARK: - AdditionalWeatherInformationDataSourceProtocol
extension AdditionalInformationDataSource: AdditionalInformationDataSourceProtocol {
    
    func update() {
        collectionView.reloadData()
    }
    
}


// MARK: - UICollectionViewDataSource
extension AdditionalInformationDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AdditionalInformationType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdditionalInformationItemCell.reuseID, for: indexPath) as? AdditionalInformationItemCell {
            let type = AdditionalInformationType(rawValue: indexPath.row)
            cell.set(title: type?.title ?? "", image: type?.image, imageWidth: type?.imageWidth ?? 16)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AdditionalInformationDataSource: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - inset) / 2
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
    
}

// MARK: - Configure
private extension AdditionalInformationDataSource {
    
    func configure() {
        registerCells()
        configureCollectionViewLayout()
        setupDataSource()
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
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
        collectionView.register(AdditionalInformationItemCell.self, forCellWithReuseIdentifier: AdditionalInformationItemCell.reuseID)
    }
    
}

