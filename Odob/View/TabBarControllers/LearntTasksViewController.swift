//
//  OrganilinganAmallarViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit
import SnapKit

@available(iOS 15.0, *)
class LearntTasksViewController: UIViewController, Themeable {
    
    let learntAmallarTableView: UITableView = {
       let tableview = UITableView()
        tableview.register(LearntTableViewCell.self, forCellReuseIdentifier: LearntTableViewCell.identifier)
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
        updateAppAppearance()
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
    
    func updateAppAppearance() {
        
        let isDarkModeEnabled = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
        let tabBarVC = tabBarController as? TabBarController
        tabBarVC?.applyDarkMode(isDarkModeEnabled)
        
    }
    
    func applyTheme(_ isDarkModeEnabled: Bool) {
        if isDarkModeEnabled {
            // Apply dark mode appearance
            learntAmallarTableView.backgroundColor = .mainBlack
            // Update other UI elements for dark mode
        } else {
            // Apply light mode appearance
            learntAmallarTableView.backgroundColor = .mainColor
            // Update other UI elements for light mode
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
        let cell = tableView.dequeueReusableCell(withIdentifier: LearntTableViewCell.identifier, for: indexPath) as! LearntTableViewCell
        cell.textLabel?.text = "h"
        cell.backgroundColor = UIColor.mainColor
        
        cell.applyTheme(UserDefaults.standard.bool(forKey: "isDarkModeEnabled"))
        return cell
    }
}
