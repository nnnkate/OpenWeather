//
//  HumidityTypeView.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 18.06.23.
//

import UIKit

final class HumidityTypeView: UIView {
    
    // - UI
    private lazy var mainView = UIView()
    private lazy var valueLabel = Label(font: .systemFont(ofSize: 32, weight: .regular))
    private lazy var titleLabel = Label(text: "humidity_subtitle".localized,
                                        font: .systemFont(ofSize: 15, weight: .medium), numberOfLines: 2)

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

// MARK: - AdditionalTypeViewProtocol
extension HumidityTypeView: AdditionalTypeViewProtocol {
    
    func set(data: CurrentWeatherData?) {
        valueLabel.text = "\(data?.humidity ?? 0)%"
    }
    
}

// MARK: - Configure
private extension HumidityTypeView {
    
    func configure() {
        configureUI()
        addSubviews()
        makeConstraints()
    }
    
    func configureUI() {
        backgroundColor = .clear
    }
    
    func addSubviews() {
        addSubview(mainView)
        mainView.addSubview(valueLabel)
        mainView.addSubview(titleLabel)
    }
    
    func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints {
            $0.top.equalTo(2)
            $0.leading.equalTo(17)
            $0.trailing.equalTo(-17)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(17)
            $0.trailing.equalTo(-17)
            $0.bottom.equalTo(-13)
        }
    }
    
}

