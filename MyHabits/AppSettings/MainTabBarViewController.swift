//
//  MainTabBarViewController.swift
//  MyHabits
//
//  Created by Roman Romanov on 04.03.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    private let habbitsVC = HabitsViewController()
    private let infoVC = InfoViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCotrollers()
    }

    private func setupCotrollers() {
        let navigationControllerHabbits = UINavigationController(rootViewController: habbitsVC)
        let navigationControllerInfo = UINavigationController(rootViewController: infoVC)
        navigationControllerHabbits.navigationBar.isHidden = true
        
        UITabBar.appearance().tintColor = AppCoolors.purple
        
        habbitsVC.tabBarItem.title = "Привычки"
        habbitsVC.tabBarItem.image = UIImage(systemName: "rectangle.grid.1x2.fill")
        
        infoVC.tabBarItem.title = "Информация"
        infoVC.tabBarItem.image = UIImage(systemName: "info.circle.fill")

        viewControllers = [navigationControllerHabbits, navigationControllerInfo]
    }

}
