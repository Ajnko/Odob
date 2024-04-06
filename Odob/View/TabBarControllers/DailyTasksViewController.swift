//
//  HomeViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit

class DailyTasksViewController: UIViewController {
    
    let homeTableView: UITableView = {
       let tableview = UITableView()
        tableview.register(DailyTasksTableViewCell.self, forCellReuseIdentifier: DailyTasksTableViewCell.identifier)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Kunlik Amallar"
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.translatesAutoresizingMaskIntoConstraints = false
        homeTableView.frame = view.bounds
    }
    
}

extension DailyTasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 80
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyTasksTableViewCell.identifier, for: indexPath) as! DailyTasksTableViewCell
        cell.textLabel?.text = "hi"
        cell.backgroundColor = .red
        return cell
    }
}
