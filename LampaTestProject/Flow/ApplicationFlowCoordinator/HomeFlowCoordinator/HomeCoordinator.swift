//
//  HomeCoordinator.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

import UIKit

final class HomeCoordinator: BaseCoordinator {
    private let factory: HomeFactory
    private let viewModel: MoviesViewModel
    
    init(router: Router, with factory: HomeFactory) {
        self.factory = factory
        self.viewModel = MoviesViewModel()
        super.init(router: router)
    }
    override func start() {
        self.showMovieListVC()
    }
    
    private func showMovieListVC() {
        let vc = factory.makeMovieListVC(viewModel: self.viewModel)
        vc.onMovieSelected = { [weak self] index in
            self?.showMovieDetailsVC(with: index)
        }
        self.router.setRootModule(vc)
    }
    
    private func showMovieDetailsVC(with index: Int) {
        let vc = factory.makeMovieDetailsVC(viewModel: self.viewModel, index: index)
        self.router.push(vc, animated: true)
    }
}
