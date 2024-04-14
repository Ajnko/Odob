//
//  OrganilinganAmallarViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit
import SnapKit

@available(iOS 15.0, *)
class LearntTasksViewController: UIViewController {
    
    let learntAmallarTableView: UITableView = {
       let tableview = UITableView()
        tableview.register(DailyTasksTableViewCell.self, forCellReuseIdentifier: DailyTasksTableViewCell.identifier)
        return tableview
    }()
    
    let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Sunnat amal qidirish"
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.searchTextField.backgroundColor = UIColor.mainColor
        controller.searchBar.searchTextField.textColor = UIColor.mainGray
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationController?.navigationBar.barTintColor = UIColor.mainColor
    }
    
    func setupUI() {
        view.addSubview(learntAmallarTableView)
        learntAmallarTableView.delegate = self
        learntAmallarTableView.dataSource = self
        learntAmallarTableView.backgroundColor = UIColor.mainColor
        learntAmallarTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }


}

@available(iOS 15.0, *)
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
        cell.backgroundColor = UIColor.mainColor
        return cell
    }
}
