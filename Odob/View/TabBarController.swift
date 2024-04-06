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
        tabBarAppereance()
        self.selectedIndex = 1
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
    
    private func tabBarAppereance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()

        let bezierPath = UIBezierPath(roundedRect: CGRect(
            x: positionOnX,
            y: tabBar.bounds.minY - positionOnY,
            width: width,
            height: height
        ), cornerRadius: height / 2)
        
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.tabBarItemAccent.cgColor
        
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .mainWhite
        tabBar.unselectedItemTintColor = .tabBarItemLight
        tabBar.isTranslucent = false
        
        let fontAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 12) ?? UIFont.systemFont(ofSize: 12)
        ]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
    }
}

