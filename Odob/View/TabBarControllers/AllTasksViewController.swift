//
//  AmallarViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit

class AllTasksViewController: UIViewController {
    
    //MARK: - Proporties
    
    let amallarTableView: UITableView = {
       let tableview = UITableView()
        tableview.register(AmallarSectionTableViewCell.self, forCellReuseIdentifier: AmallarSectionTableViewCell.identifier)
        return tableview
    }()
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view settings
        
        view.backgroundColor = .systemBackground
        self.title = "Amallar"
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel = ViewModel(sunnahTypes: Information.sunnahs, selectedTypeName: "")
        setupUI()

    }
    
    func setupUI() {
        view.addSubview(amallarTableView)
        amallarTableView.delegate = self
        amallarTableView.dataSource = self
                
        amallarTableView.translatesAutoresizingMaskIntoConstraints = false
        amallarTableView.frame = view.bounds
    }
    


}

extension AllTasksViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AmallarSectionTableViewCell.identifier, for: indexPath) as! AmallarSectionTableViewCell
        cell.amalTitle.text = viewModel.titleForRow(atIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedTypeName = viewModel.titleForRow(atIndex: indexPath.row) else {
            return
        }
        let vc = AmallarListViewController(selectedTypeName: selectedTypeName)
        navigationController?.pushViewController(vc, animated: true)
    }
}
