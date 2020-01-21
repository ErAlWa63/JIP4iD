//
//  MoviePopular.swift
//  JIP4iD
//
//  Created by Erik Waterham on 06/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

public struct MoviePopular: Codable {

    public struct Results: Codable, Identifiable {

        public let popularity: Double
        public let voteCount: Int
        public let video: Bool
        public let posterPath: String
        public let id: Int
        public let adult: Bool
        public let backdropPath: String
        public let originalLanguage: String
        public let originalTitle: String
        public let genreIds: [Int]
        public let title: String
        public let voteAverage: Double
        public let overview: String
        public let releaseDate: String
    }

    public let page: Int
    public let results: [Results]
    public let totalResults: Int
    public let totalPages: Int
}
