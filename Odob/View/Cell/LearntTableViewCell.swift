//
//  LearntTableViewCell.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 15/04/24.
//

import UIKit
import SnapKit

class LearntTableViewCell: UITableViewCell, Themeable {
    
    static let identifier = "LearntTableViewCell"
    
    let sunnahLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunnah"
        label.textColor = .textColor
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureSubview()
    }
    
    func configureSubview() {
        self.addSubview(sunnahLabel)
        sunnahLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(15)
        }
    }
    
    func applyTheme(_ isDarkModeEnabled: Bool) {
        if isDarkModeEnabled {
            self.backgroundColor = .mainBlack
            sunnahLabel.textColor = .mainColor
        } else {
            self.backgroundColor = .mainColor
            sunnahLabel.textColor = .textColor
        }
    }
    
}
