//
//  SettingsHeaderView.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 25/04/24.
//

import UIKit

class SettingsHeaderView: UIView, Themeable {
    
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let surnameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        // Configure profileImageView
        profileImageView.frame = CGRect(x: 15, y: 20, width: 90, height: 90)
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.layer.cornerRadius = 45
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.tintColor = .mainBlack
        addSubview(profileImageView)
        
        // Configure nameLabel
        nameLabel.text = "User Name"
        nameLabel.font = .boldSystemFont(ofSize: 25)
        nameLabel.textColor = .textColor
        nameLabel.frame = CGRect(x: 135, y: 20, width: 200, height: 30)
        nameLabel.font = .boldSystemFont(ofSize: 25)
        addSubview(nameLabel)
        
        // Configure surnameLabel
        surnameLabel.text = "User Surname"
        surnameLabel.font = .boldSystemFont(ofSize: 25)
        surnameLabel.textColor = .textColor
        surnameLabel.frame = CGRect(x: 135, y: 60, width: 200, height: 30)
        surnameLabel.font = .boldSystemFont(ofSize: 25)
        addSubview(surnameLabel)
        
        // Apply initial theme
        applyTheme(UserDefaults.standard.bool(forKey: "isDarkModeEnabled"))
    }
    
    // MARK: - Themeable Protocol
        
    func applyTheme(_ isDarkModeEnabled: Bool) {
            if isDarkModeEnabled {
                backgroundColor = .mainBlack
                profileImageView.tintColor = .mainColor
                nameLabel.textColor = .mainColor
                surnameLabel.textColor = .mainColor
            } else {
                backgroundColor = .mainColor
                profileImageView.tintColor = .mainBlack
                nameLabel.textColor = .textColor
                surnameLabel.textColor = .textColor
            }
        }
    
}
