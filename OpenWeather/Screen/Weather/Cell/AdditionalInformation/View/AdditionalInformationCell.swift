//
//  AdditionalInformationCell..swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

final class AdditionalInformationCell: UITableViewCell {
    
    // - Register
    static let reuseID = "AdditionalInformationCell"
    
    // - UI
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    // - DataSource
    private lazy var dataSource: AdditionalInformationDataSourceProtocol = AdditionalInformationDataSource(collectionView: collectionView)

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
extension AdditionalInformationCell {
    
    func set(data: CurrentWeatherData?) {
        dataSource.set(data: data)
    }
    
}
    
// MARK: - Configure
private extension AdditionalInformationCell {
    
    func configure() {
        configureUI()
        addSubviews()
        makeConstraints()
        dataSource.update()
    }
    
    func configureUI() {
        backgroundColor = .clear
        collectionView.backgroundColor = .clear
    }
    
    func addSubviews() {
        contentView.addSubview(collectionView)
    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
            $0.height.greaterThanOrEqualTo(400).priority(999)
        }
    }
    
}




