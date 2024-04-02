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
        generateTabBar()
        tabBarAppereance()
    }
    
    //Method generateTabBar
    private func generateTabBar() {
        viewControllers = [
            generateVC(viewController: AllTasksViewController(), title: "Home", image: UIImage(systemName: "house.fill")),
            generateVC(viewController: DailyTasksViewController(), title: "Personal Info", image: UIImage(systemName: "person.fill")),
            generateVC(viewController: LearntTasksViewController(), title: "Settings", image: UIImage(systemName: "slider.horizontal.3"))
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
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
        
        roundLayer.fillColor = UIColor.mainWhite.cgColor
        
        tabBar.backgroundColor = .clear
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
        
        let fontAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont(name: "TimesNewRomanPSMT", size: 12) ?? UIFont.systemFont(ofSize: 12)
        ]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
    }
}

