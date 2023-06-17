//
//  WeatherSectionView.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

final class WeatherSectionView: UIView {
    
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
extension WeatherSectionView {
    
    func set(title: String, image: UIImage?) {
        titleLabel.text = title
        imageView.image = image
    }
    
}

// MARK: - Configure
private extension WeatherSectionView {
    
    func configure() {
        configureUI()
        addSubviews()
        makeConstraints()
    }
    
    func configureUI() {
        backgroundColor = .clear
    }
    
    func addSubviews() {
        addBlur()
        addSubview(imageView)
        addSubview(titleLabel)
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(10)
            $0.leading.equalTo(14)
            $0.height.width.equalTo(16)
            $0.bottom.lessThanOrEqualTo(-10)
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




