//
//  ViewController.swift
//  Odob
//
//  Created by native on 26/03/24.
//

import UIKit

@available(iOS 15.0, *)
class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        self.selectedIndex = 1
        //MARK: - TabBar Settings
        self.tabBar.backgroundColor = UIColor.mainColor
        self.tabBar.tintColor = UIColor.mainBlack
        self.tabBar.unselectedItemTintColor = .mainGray
        self.tabBar.barTintColor = UIColor.mainColor
    }
    
    //Method generateTabBar
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: AllTasksViewController(), title: "Amallar", image: UIImage(systemName: "house.fill"), tag: 0),
            generateVC(viewController: DailyTasksViewController(), title: "Kunlik Amallar", image: UIImage(systemName: "person.fill"), tag: 1),
            generateVC(viewController: LearntTasksViewController(), title: "O'rganilgan Amallar", image: UIImage(systemName: "slider.horizontal.3"), tag: 2)
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?, tag: Int) -> UIViewController {
        viewController.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        viewController.title = title
        return UINavigationController(rootViewController: viewController)
    }
    
}

