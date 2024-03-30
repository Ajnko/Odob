//
//  AmallarDefinitionTableViewCell.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit

class AmallarListTableViewCell: UITableViewCell {
    
    static let identifier = "AmallarListTableViewCell"
    
    let amallarTitle: UILabel = {
       let label = UILabel()
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.addSubview(amallarTitle)
        amallarTitle.translatesAutoresizingMaskIntoConstraints = false
        amallarTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        amallarTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
    }
    
//    func updateUI(with data: [Sunnah])  {
//        amallarTitle.text = 
//    }

}
