//
//  MoviesViewModel.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

import Foundation
import UIKit

final class MoviesViewModel {
    private(set) var movies: [MovieDTO?]?
    private(set) var selectedMovie: MovieDTO?
    
    func getMoviesList(completion: @escaping (NetworkError?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            NetworkManager.shared.fetchMovies { [weak self] moviesResponse, error in
                if let error = error as? NetworkError  {
                    completion(error)
                } else {
                    self?.movies = moviesResponse?.movies
                    completion(nil)
                }
            }
        }
    }
    
    func getMoviesImage(imagePath: String, completion: @escaping (UIImage?, NetworkError?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            CacheManager.shared.loadImage(with: imagePath, completion: { image in
                if image == nil {
                    NetworkManager.shared.getMovieImage(imagePath: imagePath) { result in
                        switch result {
                        case .success(let image):
                            CacheManager.shared.cacheImage(image, with: imagePath)
                            completion(image, nil)
                        case .failure(let error):
                            if let apiError = error as? NetworkError {
                                completion(nil, apiError)
                            } else {
                                completion(nil, nil)
                            }
                            
                        }
                    }
                } else {
                    completion(image, nil)
                }
            })
        }
    }
    
    func setSelectedMovie(index: Int) {
        guard self.movies?.indices.contains(index) ?? false else { return }
        self.selectedMovie = self.movies?[index]
    }
}
