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
    
    var viewModel: ViewModel!
    var selectedTypeName: String
    
    init(selectedTypeName: String) {
        self.selectedTypeName = selectedTypeName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedTypeName
        view.backgroundColor = .systemBackground
        setupUI()
        viewModel = ViewModel(sunnahTypes: Information.sunnahs, selectedTypeName: selectedTypeName)
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
        return viewModel.countIDsInSelectedTypeName()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AmallarListTableViewCell.identifier, for: indexPath) as! AmallarListTableViewCell
        if let sunnah = viewModel.sunnahForIndexPath(indexPath) {
            cell.amalID.text = "\(sunnah.id)."
            cell.amallarTitle.text = sunnah.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedID = viewModel.sunnahForIndexPath(indexPath)?.id else {
            return
        }
        if let (name ,definition, hadis, hadisBy) = viewModel.definitionAndHadisForID(selectedID) {
            let vc = AmallarDefinitionViewController(name: name , definition: definition, hadis: hadis, haidsBy: hadisBy)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("Definition and hadis not found for ID: \(selectedID)")
        }
    }
}
