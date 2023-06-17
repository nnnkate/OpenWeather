//
//  Label.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 17.06.23.
//

import UIKit

class Label: UILabel {
    
    // - LifeCycle
    init(text: String = "",
         color: UIColor = .white,
         font: UIFont? = UIFont.systemFont(ofSize: 12),
         textAlignment: NSTextAlignment = .left,
         numberOfLines: Int = 1,
         isHidden: Bool = false) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = color
        self.font = font
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.lineBreakMode = lineBreakMode
        self.isHidden = isHidden
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
