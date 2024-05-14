//
//  SettingsViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 14/04/24.
//

import UIKit
import SnapKit

@available(iOS 15.0, *)
class SettingsViewController: UIViewController, Themeable {
    
    let settingsTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableview.register(PlanningSunnahTableViewCell.self, forCellReuseIdentifier: PlanningSunnahTableViewCell.identifier)
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
        view.backgroundColor = .mainColor
        setupUI()
        updateAppAppearance()
        configureNavigationBar()
        
    }
    
    //MARK: - UI setup
    private func setupUI() {
        view.addSubview(settingsTableView)
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.backgroundColor = UIColor.mainColor
        settingsTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        //MARK: - HeaderView for SettingsTableView
        let header = SettingsHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 120))
        settingsTableView.tableHeaderView = header
    }
    
    //MARK: - NavigationBar configuration
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.mainColor
        navigationItem.searchController = searchController
    }
    
    
    @objc func darkModeSwitchChanged(_ sender: UISwitch) {
        let isDarkModeEnabled = sender.isOn
        UserDefaults.standard.set(sender.isOn, forKey: "isDarkModeEnabled")
        updateAppAppearance()
        applyTheme(sender.isOn)
        if let headerView = settingsTableView.tableHeaderView as? SettingsHeaderView {
            headerView.applyTheme(isDarkModeEnabled)
        }
        settingsTableView.reloadData()
    }
    
    //MARK: - Updating appearance when application mode changed
    private func updateAppAppearance() {
        
        let isDarkModeEnabled = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
        let tabBarVC = tabBarController as? TabBarController
        tabBarVC?.applyDarkMode(isDarkModeEnabled)
        
    }
    
    //MARK: - Dark Mode changing
    func applyTheme(_ isDarkModeEnabled: Bool) {
        if isDarkModeEnabled {
            // Apply dark mode appearance
            settingsTableView.backgroundColor = .mainBlack
            settingsTableView.tableHeaderView?.backgroundColor = .mainBlack
            view.backgroundColor = .mainBlack
            self.navigationController?.navigationBar.barTintColor = .mainBlack
            self.settingsTableView.reloadData()
            // Update other UI elements for dark mode
        } else {
            // Apply light mode appearance
            settingsTableView.backgroundColor = .mainColor
            settingsTableView.tableHeaderView?.backgroundColor = .mainColor
            view.backgroundColor = .mainColor
            self.navigationController?.navigationBar.barTintColor = .mainColor
            self.settingsTableView.reloadData()
            // Update other UI elements for light mode
        }
    }
    
    private func applyThemeToCells(isDarkModeEnabled: Bool) {
        for cell in settingsTableView.visibleCells {
            if let themeableCell = cell as? Themeable {
                themeableCell.applyTheme(isDarkModeEnabled)
            }
        }
    }
    
    @objc func showPlanningView() {
        let planningVC = PlanningSunnahViewController()
        if let sheet = planningVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(planningVC, animated: true)
        print("tapped")
    }
    
}

@available(iOS 15.0, *)
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 80
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as! SettingsTableViewCell
            cell.backgroundColor = .mainColor
            cell.selectionStyle = .none
            cell.switchButton.isOn = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
            cell.switchButton.addTarget(self, action: #selector(darkModeSwitchChanged), for: .valueChanged)
            
            cell.applyTheme(UserDefaults.standard.bool(forKey: "isDarkModeEnabled"))
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PlanningSunnahTableViewCell.identifier, for: indexPath) as! PlanningSunnahTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = .mainColor
            cell.planningButton.addTarget(self, action: #selector(showPlanningView), for: .touchUpInside)
            return cell
        }
        
        return UITableViewCell()
    }
    
}
