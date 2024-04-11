//
//  AmallarDefinitionTableViewCell.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit
import SnapKit

class SectionTasksListTableViewCell: UITableViewCell {
    
    //MARK: - Proporties
    
    static let identifier = "AmallarListTableViewCell"
    
    let amalID: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = UIColor.textColor
        return label
    }()
    
    let amallarTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 16)
        label.textColor = UIColor.textColor
        return label
    }()
    
    let amalDefinition: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.textColor
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addProportiesToView()
        setConstraintsToSubviews()
    }
    
    //Method addProportiesToView
    private func addProportiesToView() {
        //
        self.addSubview(amalID)
        self.addSubview(amallarTitle)
        self.addSubview(amalDefinition)
    }
    
    //Method setConstraintsToSubviews
    private func setConstraintsToSubviews() {
        //amalID
        amalID.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).inset(30)
        }
        
        //amallarTitle
        amallarTitle.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(20)
            make.left.equalTo(amalID.snp.right).inset(-25)
            make.width.equalTo(self.snp.width).multipliedBy(0.7)
        }
        
        //amalDefinition
        amalDefinition.snp.makeConstraints { make in
            make.top.equalTo(amallarTitle.snp.bottom).offset(4)
            make.left.equalTo(amallarTitle.snp.left)
            make.width.equalTo(amallarTitle.snp.width)
        }
    }
    
}
