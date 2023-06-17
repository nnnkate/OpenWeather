//
//  AdditionalInformationItemCell.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

final class AdditionalInformationItemCell: UICollectionViewCell {
    
    // - Register
    static let reuseID = "AdditionalInformationItemCell"
    
    // - UI
    private lazy var mainView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 14
        return view
    }()
    private lazy var headerView = WeatherSectionHeaderView()

    // - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
        
}

// MARK: - Set
extension AdditionalInformationItemCell {
    
    func set(title: String, image: UIImage?, imageHeight: CGFloat = 16, imageWidth: CGFloat = 16) {
        headerView.set(title: title, image: image, imageHeight: imageHeight, imageWidth: imageWidth)
    }
    
}

// MARK: - Configure
private extension AdditionalInformationItemCell {
    
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
        mainView.addSubview(headerView)
    }
    
    func makeConstraints() {
       mainView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
    
}




