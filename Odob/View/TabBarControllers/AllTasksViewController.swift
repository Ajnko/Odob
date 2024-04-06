//
//  AmallarViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit
import SnapKit

@available(iOS 15.0, *)
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
        controller.searchBar.searchTextField.backgroundColor = .white
        return controller
    }()
    
    var viewModel: ViewModel!
    var imageIndices = [Int](repeating: 0, count: 4)
    
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
        amallarTableView.backgroundColor = .systemMint
        amallarTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    //MARK: - Actions -
    //Method checkMarkImageChange
    @objc func checkMarkImageChange(_ sender: UIButton) {
        
        let indexPath = IndexPath(item: sender.tag, section: 0)
        
        if imageIndices[indexPath.item] == 0 {
            imageIndices[indexPath.item] = 1
        } else {
            imageIndices[indexPath.item] = 0
        }
        
        amallarTableView.reloadData()
        
    }
    
    
}

@available(iOS 15.0, *)
extension AllTasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 80
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllTasksTableViewCell.identifier, for: indexPath) as! AllTasksTableViewCell
        cell.amalTitle.text = viewModel.titleForRow(atIndex: indexPath.row)
        
        //change image
        cell.checkmarkButton.tag = indexPath.item
        cell.checkmarkButton.addTarget(self, action: #selector(checkMarkImageChange), for: .touchUpInside)
        
        while imageIndices.count <= indexPath.item {
            imageIndices.append(0)
        }
        
        let currentImageIndex = imageIndices[indexPath.item]
        let imageName = currentImageIndex == 0 ? "unchecked" : "checked"
        
        cell.checkmarkButton.setImage(UIImage(named: imageName), for: .normal)
        
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
