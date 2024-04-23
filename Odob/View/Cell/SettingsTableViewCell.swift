//
//  SettingsTableViewCell.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 14/04/24.
//

import UIKit
import SnapKit

@available(iOS 15.0, *)
class SettingsTableViewCell: UITableViewCell, Themeable {
    
    //MARK: - Cell ID
    static let identifier = "SettingsTableViewCell"
    
    //MARK: - properties
    
    let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Dark Mode"
        label.textColor = .textColor
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    var switchButton: UISwitch = {
        let button = UISwitch()
        button.isEnabled = true
        button.onTintColor = .mainBlack
        return button
    }()
    
//    let isDarkModeEnabled = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupCell()
    }
    
    func setupCell() {
        self.addSubview(settingsLabel)
        settingsLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(15)
        }
        
        self.addSubview(switchButton)
        switchButton.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        switchButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.snp.right).offset(-20)
            make.width.equalTo(50)
            make.height.equalTo(32)
        }
        
//        applyTheme(isDarkModeEnabled)
    }
    
    @objc private func switchValueChanged(_ sender: UISwitch) {
        // Handle switch value change if needed
    }
    
    func applyTheme(_ isDarkModeEnabled: Bool) {
        if isDarkModeEnabled {
            self.backgroundColor = .mainBlack
            self.settingsLabel.textColor = .mainColor
            self.switchButton.onTintColor = .mainColor
        } else {
            self.backgroundColor = .mainColor
            self.settingsLabel.textColor = .textColor
            self.switchButton.onTintColor = .mainBlack
        }
    }
}
