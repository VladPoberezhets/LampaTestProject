//
//  ApplicationCoordinator.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    private let factory: ApplicationCoordinatorFactory
    
    private(set) var tabBarVC: TabBarVC!
    
    init(router: Router, with factory: ApplicationCoordinatorFactory) {
        self.factory = factory
        self.tabBarVC = TabBarVC()
        super.init(router: router)
    }
    override func start() {
        self.showMainVC()
    }
    
    private func showMainVC() {
        let homeRouter = Router(rootController: UINavigationController())
        let homeCoordinator = self.factory.makeHomeCoordinator(router: homeRouter)
        self.addChild(homeCoordinator)
        homeCoordinator.start()
        
        homeCoordinator.router.rootController?.tabBarItem = UITabBarItem(title: String(localized: "TAB_BAR_HOME_ITEM_TITLE"), image: UIImage(named: "homeTabBarImage"), tag: 0)
        
        
        let favouriteRouter = Router(rootController: UINavigationController())
        let favouriteCoordinator = self.factory.makeFavouriteCoordinator(router: favouriteRouter)
        self.addChild(favouriteCoordinator)
        favouriteCoordinator.start()
        favouriteCoordinator.router.rootController?.tabBarItem = UITabBarItem(title: String(localized: "TAB_BAR_FAVOURITE_ITEM_TITLE"), image: UIImage(named: "favouriteTabBarImage"), tag: 1)
        
        self.tabBarVC.viewControllers = [homeCoordinator.router.rootController!,
                                         favouriteCoordinator.router.rootController!]
        
    }
}
