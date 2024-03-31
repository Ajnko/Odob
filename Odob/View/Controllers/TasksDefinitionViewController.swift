//
//  AmallarDefinitionViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit
import SnapKit

class TasksDefinitionViewController: UIViewController {
    
    //MARK: - Proporties
    
    let nameOfAmal: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont(name: "Helvetica-Bold", size: 22)
        return label
    }()
    
    let definitionOfAmal: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textAlignment = .left
        return label
    }()
    
    let hadisOfAmal: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.textAlignment = .left
        return label
    }()
    
    let createrOfHadis: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .right
        return label
    }()
    
    var name: String
    var definition: String
    var hadis: String
    var hadisBy: String
    
    init(name: String, definition: String, hadis: String, haidsBy: String) {
        self.name = name
        self.definition = definition
        self.hadis = hadis
        self.hadisBy = haidsBy
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view settings
        view.backgroundColor = .systemBackground
        addProportiesToView()
        setConstraintsToSubviews()
    }
    
    //Method addProportiesToView
    private func addProportiesToView() {
        //to view
        view.addSubview(nameOfAmal)
        view.addSubview(definitionOfAmal)
        view.addSubview(hadisOfAmal)
        view.addSubview(createrOfHadis)
    }
    
    //Method setConstraintsToSubviews
    private func setConstraintsToSubviews() {
        //nameOfAmal
        nameOfAmal.text = name
        nameOfAmal.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY).multipliedBy(0.24)
            make.left.equalTo(view.snp.left).offset(25)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
        }
        
        //definitionOfAmal
        definitionOfAmal.text = "Тавсиф: \(definition)"
        definitionOfAmal.snp.makeConstraints { make in
            make.top.equalTo(nameOfAmal.snp.bottom).offset(10)
            make.left.equalTo(view.snp.left).offset(30)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
        }
        
        //hadisOfAmal
        hadisOfAmal.text = hadis
        hadisOfAmal.snp.makeConstraints { make in
            make.top.equalTo(definitionOfAmal.snp.bottom).offset(1)
            make.left.equalTo(view.snp.left).offset(30)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
        }
        
        //createrOfHadis
        createrOfHadis.text = hadisBy
        createrOfHadis.snp.makeConstraints { make in
            make.top.equalTo(hadisOfAmal.snp.bottom).offset(2)
            make.right.equalTo(view.snp.right).offset(-10)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
        }
    }
}
