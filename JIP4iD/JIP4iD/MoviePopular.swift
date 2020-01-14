//
//  MoviePopular.swift
//  JIP4iD
//
//  Created by Erik Waterham on 06/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

struct MoviePopular: Codable {

    struct Results: Codable, Identifiable {

        let popularity: Double
        let voteCount: Int
        let video: Bool
        let posterPath: String
        let id: Int
        let adult: Bool
        let backdropPath: String
        let originalLanguage: String
        let originalTitle: String
        let genreIds: [Int]
        let title: String
        let voteAverage: Double
        let overview: String
        let releaseDate: String
    }
    
    let page: Int
    let results: [Results]
    let totalResults: Int
    let totalPages: Int
}
