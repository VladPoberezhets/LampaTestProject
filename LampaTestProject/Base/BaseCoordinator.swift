//
//  BaseCoordinator.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

import UIKit

protocol Coordinator: NSObject {
    var router: Router { get }
    func start()
}

class BaseCoordinator: NSObject, Coordinator {
    let router: Router
    
    var childCoordinators: [Coordinator] = []
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {}
     
     func addChild(_ coordinator: Coordinator) {
         guard !childCoordinators.contains(where: {$0 === coordinator}) else {
             return
         }
         childCoordinators.append(coordinator)
     }
     
     func removeChild(_ coordinator: Coordinator?) {
         guard !childCoordinators.isEmpty, let coordinator = coordinator else {
             return
         }
         if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
             coordinator.childCoordinators.filter({$0 !== coordinator}).forEach({ coordinator.removeChild($0) })
         }
         for (index, element) in childCoordinators.enumerated() where element === coordinator {
             childCoordinators.remove(at: index)
             break
         }
     }

}
