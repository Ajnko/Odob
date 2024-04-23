//
//  DailyTasksCollectionViewCellCollectionViewCell.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 15/04/24.
//

import UIKit

class DailyTasksCollectionViewCell: UICollectionViewCell, Themeable {
    
    static let identifier = "DailyTasksCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyTheme(_ isDarkModeEnabled: Bool) {
        if isDarkModeEnabled {
            self.backgroundColor = .mainBlack
        } else {
            self.backgroundColor = .mainColor
        }
    }
    
}
