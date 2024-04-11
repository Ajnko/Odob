//
//  HomeViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit
import SnapKit

@available(iOS 15.0, *)
class DailyTasksViewController: UIViewController {
    
    let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundimage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let dailyTasksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .vertical
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Sunnat amal qidirish"
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.searchTextField.backgroundColor = UIColor.mainColor
        controller.searchBar.searchTextField.textColor = UIColor.tabBarItemAccent
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainColor
        setupUI()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        
        print(view.frame.width, view.frame.height)
    }
    
    func setupUI() {
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(dailyTasksCollectionView)
        dailyTasksCollectionView.delegate = self
        dailyTasksCollectionView.dataSource = self
        dailyTasksCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.width.height.equalToSuperview()
        }
    }
    
}

@available(iOS 15.0, *)
extension DailyTasksViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.mainColor
        cell.layer.cornerRadius = 15
        cell.layer.borderColor = UIColor.textColor.cgColor
        cell.layer.borderWidth = 2
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width) - 40, height: (view.frame.height) / 10)
    }
    
}
