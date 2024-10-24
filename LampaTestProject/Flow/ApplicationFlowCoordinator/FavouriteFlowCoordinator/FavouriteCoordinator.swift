//
//  FavouriteCoordinator.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

final class FavouriteCoordinator: BaseCoordinator {
    private let factory: FavouriteFactory
    
    init(router: Router, with factory: FavouriteFactory) {
        self.factory = factory
        super.init(router: router)
    }
    override func start() {
        self.showMovieFavouriteListVC()
    }
    
    private func showMovieFavouriteListVC() {
        let vc = factory.makeMovieFavouriteListVC()
        self.router.setRootModule(vc, animated: false)
    }
}
