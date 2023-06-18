//
//  WindTypeView.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 18.06.23.
//

import UIKit

final class WindTypeView: UIView {
    
    // - UI
    private lazy var mainView = UIView()
    private lazy var imageView = UIImageView(image: UIImage(named: "wind"))
    private lazy var stackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillProportionally
        view.contentMode = .center
        return view
    }()
    private lazy var valueLabel = Label(font: .systemFont(ofSize: 20), textAlignment: .center)
    private lazy var titleLabel = Label(font: .systemFont(ofSize: 14, weight: .medium), textAlignment: .center)

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

// MARK: - Update
private extension WindTypeView {
    
    func updateData() {
        // TODO: for test
        valueLabel.text = "1"
        titleLabel.text = "m/s"
    }
    
}

// MARK: - Configure
private extension WindTypeView {
    
    func configure() {
        configureUI()
        addSubviews()
        makeConstraints()
        updateData()
    }
    
    func configureUI() {
        backgroundColor = .clear
    }
    
    func addSubviews() {
        addSubview(mainView)
        mainView.addSubview(imageView)
        mainView.addSubview(stackView)
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(titleLabel)
    }
    
    func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        let inset: CGFloat = 24
        imageView.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(inset).priority(999)
            $0.trailing.lessThanOrEqualTo(-inset).priority(999)
            $0.center.equalToSuperview()
            $0.top.equalTo(10)
            $0.bottom.equalTo(-10)
            $0.width.equalTo(imageView.snp.height)
        }
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(14).priority(999)
            $0.trailing.lessThanOrEqualTo(-14).priority(999)
        }
    }
    
}

