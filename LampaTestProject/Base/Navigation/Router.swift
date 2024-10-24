//
//  Router.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

import UIKit

final class Router: NSObject, RouterDelegate {
    var rootModule: Presentable? {
        return rootController
    }
    
    var rootController: UINavigationController?
    
    init(rootController: UINavigationController) {
        self.rootController = rootController;
    }
    
    deinit {
        self.rootController = nil
    }
    
    func present(_ module: Presentable?, with animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.present(controller, animated: animated)
    }
    
    func push(_ module: Presentable?) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.pushViewController(controller, animated: true)
    }
    
    func push(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootController?.pushViewController(controller, animated: animated)
    }
    
    func pop(animated: Bool) {
        self.rootController?.popViewController(animated: animated)
    }
    
    func setRootModule(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else {return}

        self.rootController?.setViewControllers([controller], animated: animated)
        self.rootController?.viewControllers.forEach({ (vc) in
            rootController?.view.bringSubviewToFront(vc.view)
        })
    }
    
    func popToRoot(animated: Bool = true) {
        self.rootController?.popToRootViewController(animated: animated)
    }
    
    func popToModule(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else {return}
        rootController?.popToViewController(controller, animated: animated)
    }
}
