//
//  AmallarTableViewCell.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit

class AmallarSectionTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier = "AmallarSectionTableViewCell"
    
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
        self.addSubview(amalTitle)
        amalTitle.translatesAutoresizingMaskIntoConstraints = false
        amalTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        amalTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
   
    }

    func updateUI(with data: SunnahType)  {
        amalTitle.text = data.typeName
    }
    
}
