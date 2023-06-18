//
//  UIView+Blur.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

extension UIView {
    
    func addBlur(alpha: CGFloat = 0.85) {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffect = UIVisualEffectView(effect: blurEffect)
        visualEffect.frame = self.bounds
        visualEffect.alpha = alpha
        visualEffect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        visualEffect.clipsToBounds = true
        self.addSubview(visualEffect)
        visualEffect.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func removeBlur() {
        self.subviews.forEach {
            if $0 is UIVisualEffectView {
                $0.removeFromSuperview()
            }
        }
    }
    
}
