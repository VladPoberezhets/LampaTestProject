//
//  TabBarVC.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

import UIKit

final class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.tabBar.backgroundColor = .white
        self.tabBar.itemPositioning = .fill
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor(named: "highlightedOrange")
    }
}
