//
//  LearntTableViewCell.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 15/04/24.
//

import UIKit

class LearntTableViewCell: UITableViewCell {
    
    static let identifier = "LearntTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func applyTheme(_ isDarkModeEnabled: Bool) {
        if isDarkModeEnabled {
            self.backgroundColor = .mainBlack
        } else {
            self.backgroundColor = .mainColor
        }
    }

}
