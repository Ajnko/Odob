//
//  ViewController.swift
//  Odob
//
//  Created by native on 26/03/24.
//

import UIKit

protocol Themeable {
    func applyTheme(_ isDarkModeEnabled: Bool)
}

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
            generateVC(viewController: LearntTasksViewController(), title: "O'rganilgan Amallar", image: UIImage(systemName: "slider.horizontal.3"), tag: 2),
            generateVC(viewController: SettingsViewController(), title: "Sozlamalar", image: UIImage(systemName: "gear"), tag: 3)
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?, tag: Int) -> UIViewController {
        viewController.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        viewController.title = title
        return UINavigationController(rootViewController: viewController)
    }
    
    func applyDarkMode(_ isDarkModeEnabled: Bool) {
        // Update appearance of all child view controllers based on dark mode state
        viewControllers?.forEach { viewController in
            if let navController = viewController as? UINavigationController {
                navController.viewControllers.forEach { childViewController in
                    applyDarkModeToViewController(childViewController, isDarkModeEnabled: isDarkModeEnabled)
                }
            } else {
                applyDarkModeToViewController(viewController, isDarkModeEnabled: isDarkModeEnabled)
            }
        }
    }
    
    private func applyDarkModeToViewController(_ viewController: UIViewController, isDarkModeEnabled: Bool) {
        if let themeableVC = viewController as? Themeable {
            themeableVC.applyTheme(isDarkModeEnabled)
        }
    }
    
}

