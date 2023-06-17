//
//  WeatherSectionHeaderView.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

final class WeatherSectionHeaderView: UIView {
    
    // - UI
    private lazy var imageView = {
        let view = UIImageView()
        view.tintColor = .transparentTextColor
       return view
    }()
    private lazy var titleLabel = Label(color: .transparentTextColor,
                                        font: UIFont(name: "Inter-Medium", size: 13))

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
extension WeatherSectionHeaderView {
    
    func set(title: String, image: UIImage?, imageHeight: CGFloat = 16, imageWidth: CGFloat = 16) {
        titleLabel.text = title
        imageView.image = image
        imageView.snp.updateConstraints {
            $0.width.equalTo(imageWidth)
            $0.height.equalTo(imageHeight)
        }
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
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(10).priority(999)
            $0.leading.equalTo(14)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
            $0.bottom.lessThanOrEqualTo(-10).priority(999)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(14)
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.trailing.equalTo(-16)
            $0.centerY.equalToSuperview()
            $0.bottom.equalTo(-14)
        }
    }
    
}
