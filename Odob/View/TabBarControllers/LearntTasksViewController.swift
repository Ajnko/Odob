//
//  OrganilinganAmallarViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit

class LearntTasksViewController: UIViewController {
    
    let learntAmallarTableView: UITableView = {
       let tableview = UITableView()
        tableview.register(DailyTasksTableViewCell.self, forCellReuseIdentifier: DailyTasksTableViewCell.identifier)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "O'rganilgan Amallar"
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(learntAmallarTableView)
        learntAmallarTableView.delegate = self
        learntAmallarTableView.dataSource = self
        learntAmallarTableView.translatesAutoresizingMaskIntoConstraints = false
        learntAmallarTableView.frame = view.bounds
    }


}

extension LearntTasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 80
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DailyTasksTableViewCell.identifier, for: indexPath) as! DailyTasksTableViewCell
        cell.textLabel?.text = "h"
        return cell
    }
}
