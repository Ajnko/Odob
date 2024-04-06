//
//  AmallarViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit
import SnapKit

class AllTasksViewController: UIViewController {
    
    //MARK: - Proporties
    
    let amallarTableView: UITableView = {
       let tableview = UITableView()
        tableview.register(AllTasksTableViewCell.self, forCellReuseIdentifier: AllTasksTableViewCell.identifier)
        return tableview
    }()
    
    let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Sunnat amal qidirish"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view settings
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        viewModel = ViewModel(sunnahTypes: Information.sunnahs, selectedTypeName: "")
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(amallarTableView)
        amallarTableView.delegate = self
        amallarTableView.dataSource = self
        amallarTableView.rowHeight = 70
        amallarTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    


}

extension AllTasksViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllTasksTableViewCell.identifier, for: indexPath) as! AllTasksTableViewCell
        cell.amalTitle.text = viewModel.titleForRow(atIndex: indexPath.row)
        cell.backgroundColor = .orange
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedTypeName = viewModel.titleForRow(atIndex: indexPath.row) else {
            return
        }
        let vc = TasksListViewController(selectedTypeName: selectedTypeName)
        navigationController?.pushViewController(vc, animated: true)
    }
}
