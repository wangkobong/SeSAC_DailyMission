//
//  TVShowsModel.swift
//  SearchTVShows
//
//  Created by sungyeon kim on 2021/12/23.
//

import Foundation

// MARK: - TVShows
struct TVShows: Codable {
    let page: Int
    let results: [Items]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Items: Codable {
    let genreIDS: [Int]
    let originalLanguage, posterPath: String
    let voteCount: Int
    let voteAverage: Double
    let overview: String
    let id: Int
    let originalName, firstAirDate: String
    let originCountry: [String]
    let name, backdropPath: String
    let popularity: Double

    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case posterPath = "poster_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case overview, id
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case name
        case backdropPath = "backdrop_path"
        case popularity
    }
}
