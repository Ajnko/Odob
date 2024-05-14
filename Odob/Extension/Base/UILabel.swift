//
//  UILabel.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 10/05/24.
//

import UIKit

class Label: UILabel {
    init(text: String, textColor: UIColor, fontSize: UIFont, numberOfLines: Int) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.font = fontSize
        self.numberOfLines = numberOfLines
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
