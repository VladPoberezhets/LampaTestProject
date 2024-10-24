//
//  NetworkManager.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

import Foundation
import UIKit

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)

    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .noData:
            return "No data received."
        case .decodingError:
            return "Failed to decode the response."
        case .serverError(let statusCode):
            return "Server error with status code: \(statusCode)"
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private let fetchMoviesUrlString: String = "https://api.themoviedb.org/3/movie/popular"
    private let getMovieImageUrlString: String = "https://image.tmdb.org/t/p/w500"
    
    private lazy var headers: [String: String] = {
        return ["Content-Type": "application/json"]
    }()
    
    func fetchMovies(completion: @escaping (MovieModelsDTO?, Error?) -> Void) {
        guard var urlComponents = URLComponents(string: fetchMoviesUrlString) else {
            print(NetworkError.invalidURL.errorDescription)
            completion(nil, NetworkError.invalidURL)
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: "ed0957c3c3f2acb89d27b394e9612d5e"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "language", value: "en-US")
        ]
        
        guard let url = urlComponents.url else {
            print(NetworkError.invalidURL.errorDescription)
            completion(nil, NetworkError.invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            switch self.validateResponse(response, data: data, error: error) {
            case .success(let responseData):
                do {
                    let movieResponse = try JSONDecoder().decode(MovieModelsDTO.self, from: responseData)
                    completion(movieResponse, nil)
                } catch {
                    print(NetworkError.decodingError.errorDescription)
                    completion(nil, NetworkError.decodingError)
                }
            case .failure(let error):
                completion(nil, error)
            }
          
        }
        task.resume()
    }
    
    func getMovieImage(imagePath: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let urlComponents = URLComponents(string: getMovieImageUrlString + imagePath) else {
            print(NetworkError.invalidURL.errorDescription)
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        guard let url = urlComponents.url else {
            print(NetworkError.invalidURL.errorDescription)
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            switch self.validateResponse(response, data: data, error: error) {
            case .success(let responseData):
                if let image = UIImage(data: responseData) {
                    completion(.success(image))
                } else {
                    print(NetworkError.noData.errorDescription)
                    completion(.failure(NetworkError.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
          
        }
        task.resume()
    }
}

extension NetworkManager {
    private func validateResponse(_ response: URLResponse?, data: Data?, error: Error?) -> Result<Data, Error> {
        if let error = error {
            print(error.localizedDescription)
            return .failure(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print(NetworkError.noData.errorDescription)
            return .failure(NetworkError.noData)
        }
        
        guard (200...300).contains(httpResponse.statusCode) else {
            print(NetworkError.serverError(statusCode: httpResponse.statusCode).errorDescription)
            return .failure(NetworkError.serverError(statusCode: httpResponse.statusCode))
        }
        
        guard let data = data else {
            print(NetworkError.noData.errorDescription)
            return .failure(NetworkError.noData)
        }
        return .success(data)
    }
}
