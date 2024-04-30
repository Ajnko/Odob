//
//  HomeViewController.swift
//  Odob
//
//  Created by Abdulbosid Jalilov on 27/03/24.
//

import UIKit
import SnapKit

@available(iOS 15.0, *)
class DailyTasksViewController: UIViewController, Themeable {
    
    //MARK: - Properties
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundimage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let dailyTasksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .vertical
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(DailyTasksCollectionViewCell.self, forCellWithReuseIdentifier: DailyTasksCollectionViewCell.identifier)
        collectionview.backgroundColor = .clear
        return collectionview
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Sunnat amal qidirish"
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.searchTextField.backgroundColor = UIColor.mainColor
        controller.searchBar.searchTextField.textColor = UIColor.mainGray
        return controller
    }()
    
    var viewModel: DailyTasksViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainColor
        setupUI()
        configureNavigationBar()
        updateAppAppearance()
        
        viewModel = DailyTasksViewModel(sunnahTypes: Information.sunnahs, currentDate: Date())
        
        updateUI()

        
    }
    
    //MARK: - UI setup
    private func setupUI() {
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
    
    func updateUI() {
        guard let sunnah = viewModel.currentSunnah() else {
            print("No Sunnah data available")
            return
        }
        print("Current Sunnah: \(sunnah.name)")
        
        dailyTasksCollectionView.reloadData()
    }
    
    
    //MARK: - NavigationBar configuration
    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .mainColor
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
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
            view.backgroundColor = .mainBlack
            self.navigationController?.navigationBar.barTintColor = .mainBlack
            self.dailyTasksCollectionView.reloadData()
            // Update other UI elements for dark mode
        } else {
            // Apply light mode appearance
            view.backgroundColor = .mainColor
            self.navigationController?.navigationBar.barTintColor = .mainColor
            self.dailyTasksCollectionView.reloadData()
            // Update other UI elements for light mode
        }
    }
    
}

@available(iOS 15.0, *)
extension DailyTasksViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyTasksCollectionViewCell.identifier, for: indexPath) as! DailyTasksCollectionViewCell
        cell.backgroundColor = UIColor.mainColor
        cell.layer.cornerRadius = 15
        cell.layer.borderColor = UIColor.textColor.cgColor
        cell.layer.borderWidth = 2
        cell.layer.masksToBounds = true
        
        cell.applyTheme(UserDefaults.standard.bool(forKey: "isDarkModeEnabled"))
        
        if let sunnah = viewModel.currentSunnah() {
            cell.configureView(with: sunnah)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width) - 40, height: (view.frame.height) / 10)
    }
    
}
