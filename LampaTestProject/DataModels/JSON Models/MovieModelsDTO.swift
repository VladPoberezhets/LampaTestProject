//
//  MovieModelsDTO.swift
//  LampaTestProject
//
//  Created by Vlad Poberezhets on 23.10.2024.
//

import Foundation

// MARK: - Movies
struct MovieModelsDTO: Codable {
    let dates: Dates?
    let page: Int?
    let movies: [MovieDTO?]
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates, page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    struct Dates: Codable {
        let maximum, minimum: String
    }
}

// MARK: - Result
struct MovieDTO: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int?
    let originalLanguage: OriginalLanguage?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    enum OriginalLanguage: String, Codable {
        case en = "en"
        case es = "es"
        case ko = "ko"
        case xx = "xx"
    }
}


