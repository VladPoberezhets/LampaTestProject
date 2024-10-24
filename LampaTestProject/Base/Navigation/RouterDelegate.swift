//
//  RouterDelegate.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

protocol RouterDelegate: AnyObject {
    var rootModule: Presentable? { get }
    func push(_ module: Presentable?, animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func setRootModule(_ module: Presentable?, animated: Bool)
}

extension RouterDelegate {
    func pop() {
        self.pop(animated: true)
    }
    
    func setRootModule(_ module: Presentable?) {
        self.setRootModule(module, animated: false)
    }
    
    func setRootModule(_ moduel: Presentable?, animated: Bool) {
        self.setRootModule(moduel, animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        self.popToRoot(animated: animated)
    }
}
