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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.mainColor
        navigationItem.searchController = searchController
        updateAppAppearance()
    }
    
    func setupUI() {
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
        let header = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 120))
        header.backgroundColor = .mainColor
        
        //MARK: - HeaderView properties
        let profileImageView = UIImageView(frame: CGRect(x: 15, y: 20, width: 90, height: 90))
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.backgroundColor = .mainColor
        profileImageView.layer.cornerRadius = 45
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.tintColor = .mainBlack
        header.addSubview(profileImageView)
        
        let nameLabel = UILabel(frame: CGRect(x: 135, y: 20, width: 200, height: 30))
        nameLabel.text = "User Name"
        nameLabel.font = .boldSystemFont(ofSize: 25)
        nameLabel.textColor = .textColor
        nameLabel.backgroundColor = .mainColor
        header.addSubview(nameLabel)
        
        let surnameLabel = UILabel(frame: CGRect(x: 135, y: 60, width: 200, height: 30))
        surnameLabel.text = "User Surname"
        surnameLabel.font = .boldSystemFont(ofSize: 25)
        surnameLabel.textColor = .textColor
        surnameLabel.backgroundColor = .mainColor
        header.addSubview(surnameLabel)
        settingsTableView.tableHeaderView = header
    }
    
    
    @objc func darkModeSwitchChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "isDarkModeEnabled")
        updateAppAppearance()
        applyTheme(sender.isOn)
        settingsTableView.reloadData()
    }
    
    func updateAppAppearance() {
        
        let isDarkModeEnabled = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
        let tabBarVC = tabBarController as? TabBarController
        tabBarVC?.applyDarkMode(isDarkModeEnabled)

    }
    
    func applyTheme(_ isDarkModeEnabled: Bool) {
        if isDarkModeEnabled {
            // Apply dark mode appearance
            settingsTableView.backgroundColor = .mainBlack
            settingsTableView.tableHeaderView?.backgroundColor = .mainBlack
            // Update other UI elements for dark mode
        } else {
            // Apply light mode appearance
            settingsTableView.backgroundColor = .mainColor
            settingsTableView.tableHeaderView?.backgroundColor = .mainColor
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
    
}

@available(iOS 15.0, *)
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 80
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as! SettingsTableViewCell
        cell.backgroundColor = .mainColor
        cell.selectionStyle = .none
        cell.switchButton.isOn = UserDefaults.standard.bool(forKey: "isDarkModeEnabled")
        cell.switchButton.addTarget(self, action: #selector(darkModeSwitchChanged), for: .valueChanged)
        
        cell.applyTheme(UserDefaults.standard.bool(forKey: "isDarkModeEnabled"))
        return cell
    }
    
}
