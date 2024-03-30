//
//  AmallarDefinitionViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit

class AmallarDefinitionViewController: UIViewController {

    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Уйқудан уйғонишдаги суннатлар"
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let sunnatAmalLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 5
        label.textAlignment = .left
        label.text = "Уйқу дангасалиги ва унинг асоратини қўл билан юздан аритиш."
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        
        view.addSubview(sunnatAmalLabel)
        sunnatAmalLabel.translatesAutoresizingMaskIntoConstraints = false
        sunnatAmalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sunnatAmalLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        sunnatAmalLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    


}
