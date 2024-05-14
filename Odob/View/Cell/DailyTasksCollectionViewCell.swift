//
//  DailyTasksCollectionViewCellCollectionViewCell.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 15/04/24.
//

import UIKit
import SnapKit

class DailyTasksCollectionViewCell: UICollectionViewCell, Themeable {
    
    //MARK: - Properties
    static let identifier = "DailyTasksCollectionViewCell"
    
    let sunnahLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .textColor
        label.numberOfLines = 2
        return label
    }()
    
    let sunnahDefinitionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(sunnahLabel)
        sunnahLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(15)
            make.left.equalTo(self.snp.left).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(1)
        }
        
        self.addSubview(sunnahDefinitionLabel)
        sunnahDefinitionLabel.snp.makeConstraints { make in
            make.top.equalTo(sunnahLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
        }
    }
    
    func configureView(with sunnah: Sunnah) {
        sunnahLabel.text = sunnah.name
        sunnahDefinitionLabel.text = sunnah.definition
    }
    
    func applyTheme(_ isDarkModeEnabled: Bool) {
        if isDarkModeEnabled {
            self.backgroundColor = .mainBlack
            sunnahLabel.textColor = .mainColor
            sunnahDefinitionLabel.textColor = .mainColor
        } else {
            self.backgroundColor = .mainColor
            sunnahLabel.textColor = .textColor
            sunnahDefinitionLabel.textColor = .textColor
        }
    }
    
}
