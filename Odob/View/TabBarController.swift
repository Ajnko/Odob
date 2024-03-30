//
//  ViewController.swift
//  Odob
//
//  Created by native on 26/03/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTabBar()
        self.selectedIndex = 1
    }
    
    func setupTabBar() {
        let amallar = AmallarViewController()
        amallar.tabBarItem = UITabBarItem(title: "Amallar", image: UIImage(systemName: "list.bullet.circle"), selectedImage: UIImage(systemName: "list.bullet.circle.fill"))
        
        let home = HomeViewController()
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.circle"), selectedImage: UIImage(systemName: "house.circle.fill"))
        
        let learntAmallar = OrganilganAmallarViewController()
        learntAmallar.tabBarItem = UITabBarItem(title: "Oranilgan", image: UIImage(systemName: "checkmark.rectangle.stack"), selectedImage: UIImage(systemName: "checkmark.rectangle.stack.fill"))
        
        tabBar.tintColor = #colorLiteral(red: 0.07854471356, green: 0.3264657259, blue: 0.2102289796, alpha: 1)
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        viewControllers = [amallar, home, learntAmallar]
    }


}

