//
//  HomeFactory.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

final class HomeFactory {
    func makeMovieListVC(viewModel: MoviesViewModel) -> MovieListVC {
        return MovieListVC(viewModel: viewModel)
    }
    
    func makeMovieDetailsVC(viewModel: MoviesViewModel) -> MoviewDetailsVC {
        return MoviewDetailsVC(viewModel: viewModel)
    }
}
