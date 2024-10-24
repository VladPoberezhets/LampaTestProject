//
//  ApplicationCoordinatorFactory.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

final class ApplicationCoordinatorFactory {
    func makeHomeCoordinator(router: Router) -> Coordinator {
        let factory = HomeFactory()
        return HomeCoordinator(router: router, with: factory)
    }
    func makeFavouriteCoordinator(router: Router) -> Coordinator {
        let factory = FavouriteFactory()
        return FavouriteCoordinator(router: router, with: factory)
    }
}
