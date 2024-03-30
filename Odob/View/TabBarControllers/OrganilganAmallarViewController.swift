//
//  OrganilinganAmallarViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit

class OrganilganAmallarViewController: UIViewController {
    
    let learntAmallarTableView: UITableView = {
       let tableview = UITableView()
        tableview.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(learntAmallarTableView)
        learntAmallarTableView.delegate = self
        learntAmallarTableView.dataSource = self
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 80))
        header.backgroundColor = #colorLiteral(red: 0.07854471356, green: 0.3264657259, blue: 0.2102289796, alpha: 1)
        learntAmallarTableView.tableHeaderView = header
        
        let titleLabel = UILabel(frame: CGRect(x: 15, y: 20, width: 500, height: 50))
        titleLabel.text = "O'rganilgan Sunnat Amallar"
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.textColor = .white
        header.addSubview(titleLabel)
        
        learntAmallarTableView.translatesAutoresizingMaskIntoConstraints = false
        learntAmallarTableView.frame = view.bounds
    }


}

extension OrganilganAmallarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 80
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        cell.textLabel?.text = "h"
        return cell
    }
}
