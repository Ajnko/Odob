//
//  AmallarDefinitionTableViewCell.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit
import SnapKit

class AmallarListTableViewCell: UITableViewCell {
    
    //MARK: - Proporties
    
    static let identifier = "AmallarListTableViewCell"
    
    let amalID: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        return label
    }()
    
    let amallarTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 3
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
    }
    
    //Method setConstraintsToSubviews
    private func setConstraintsToSubviews() {
        //amalID
        amalID.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).inset(15)
        }
        
        //amallarTitle
        amallarTitle.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(amalID.snp.right).inset(-5)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
        }
    }
    
}
