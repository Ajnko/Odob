//
//  PlanningSunnahTableViewCell.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 10/05/24.
//

import UIKit
import SnapKit

class PlanningSunnahTableViewCell: UITableViewCell {
    
    static let identifier = "PlanningSunnahTableViewCell"
    
    let planningSunnahLabel = Label(text: "Planning sunnah", textColor: .textColor, fontSize: .boldSystemFont(ofSize: 20), numberOfLines: 0)
    
    let planningButton: UIButton = {
       let button = UIButton()
        button.setTitle("Plan", for: .normal)
        button.setTitleColor(.mainColor, for: .normal)
        button.backgroundColor = .mainBlack
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupCell()
    }
    
    private func setupCell() {
        self.addSubview(planningSunnahLabel)
        planningSunnahLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(15)
        }
        
        self.addSubview(planningButton)
        planningButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.snp.right).offset(-18)
            make.width.equalTo(self.snp.width).multipliedBy(0.2)
            make.height.equalTo(self.snp.height).multipliedBy(0.6)
        }
    }

}
