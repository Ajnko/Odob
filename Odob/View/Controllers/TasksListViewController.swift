//
//  AmallarListViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit
import SnapKit

class TasksListViewController: UIViewController {
    
    let amallarTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(SectionTasksListTableViewCell.self, forCellReuseIdentifier: SectionTasksListTableViewCell.identifier)
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
        self.navigationItem.largeTitleDisplayMode = .never
        setupUI()
        viewModel = ViewModel(sunnahTypes: Information.sunnahs, selectedTypeName: selectedTypeName)
    }
    
    func setupUI() {
        view.addSubview(amallarTableView)
        amallarTableView.delegate = self
        amallarTableView.dataSource = self
        amallarTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    
}

extension TasksListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 80
        return height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countIDsInSelectedTypeName()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SectionTasksListTableViewCell.identifier, for: indexPath) as! SectionTasksListTableViewCell
        if let sunnah = viewModel.sunnahForIndexPath(indexPath) {
            cell.amalID.text = "\(sunnah.id)."
            cell.amallarTitle.text = sunnah.name
            cell.amalDefinition.text = sunnah.hadis
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedID = viewModel.sunnahForIndexPath(indexPath)?.id else {
            return
        }
        if let (name ,definition, hadis, hadisBy) = viewModel.definitionAndHadisForID(selectedID) {
            let vc = TasksDefinitionViewController(name: name , definition: definition, hadis: hadis, haidsBy: hadisBy)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("Definition and hadis not found for ID: \(selectedID)")
        }
    }
}
