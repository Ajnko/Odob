//
//  AmallarListViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit

class AmallarListViewController: UIViewController {
    
    let amallarTableView: UITableView = {
       let tableview = UITableView()
        tableview.register(AmallarListTableViewCell.self, forCellReuseIdentifier: AmallarListTableViewCell.identifier)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Уйқудан уйғонишдаги суннатлари"
        view.backgroundColor = .systemBackground
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

extension AmallarListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 80
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AmallarListTableViewCell.identifier, for: indexPath) as! AmallarListTableViewCell
        cell.textLabel?.text = "h"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AmallarDefinitionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
