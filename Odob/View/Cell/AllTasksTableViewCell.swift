//
//  AmallarTableViewCell.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit

class AllTasksTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier = "AmallarSectionTableViewCell"
    
    let checkmarkButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let amalTitle: UILabel = {
        let label = UILabel()
        label.text = "Уйқудан уйғонишдаги суннатлар"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //checkmarkButton
        self.addSubview(checkmarkButton)
        checkmarkButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(20)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        //amalTitle
        self.addSubview(amalTitle)
        amalTitle.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(checkmarkButton.snp.right).inset(-10)
        }
        
    }
    
    func updateUI(with data: SunnahType)  {
        amalTitle.text = data.typeName
    }
    
}
