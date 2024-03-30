//
//  AmallarViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit

class AmallarViewController: UIViewController {
    
    let amallarTableView: UITableView = {
       let tableview = UITableView()
        tableview.register(AmallarSectionTableViewCell.self, forCellReuseIdentifier: AmallarSectionTableViewCell.identifier)
        return tableview
    }()
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()

    }
    
    func setupUI() {
        view.addSubview(amallarTableView)
        amallarTableView.delegate = self
        amallarTableView.dataSource = self
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 80))
        header.backgroundColor = #colorLiteral(red: 0.07854471356, green: 0.3264657259, blue: 0.2102289796, alpha: 1)
        amallarTableView.tableHeaderView = header
        
        let titleLabel = UILabel(frame: CGRect(x: 15, y: 20, width: 200, height: 50))
        titleLabel.text = "Amallar"
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.textColor = .white
        header.addSubview(titleLabel)
        
        amallarTableView.translatesAutoresizingMaskIntoConstraints = false
        amallarTableView.frame = view.bounds
    }
    


}

extension AmallarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 70
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sunnahViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AmallarSectionTableViewCell.identifier, for: indexPath) as! AmallarSectionTableViewCell
        cell.updateUI(with: viewModel.sunnahViewModel[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AmallarListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
