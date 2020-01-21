//
//  Movie.swift
//  JIP4iD
//
//  Created by Erik Waterham on 08/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

public struct Movie: Codable {

    public struct BelongsToCollection: Codable, Identifiable {
        public let id: Int
        public let name: String
        public let posterPath: String?
        public let backdropPath: String?
    }

    public struct Genres: Codable, Identifiable {

        public let id: Int
        public let name: String
    }

    public struct ProductionCompanies: Codable, Identifiable {

        public let id: Int
        public let logoPath: String?
        public let name: String
        public let originCountry: String
    }

    public struct ProductionCountries: Codable {

        public let iso31661: String
        public let name: String
    }

    public struct SpokenLanguages: Codable {

        public let iso6391: String?
        public let name: String?
    }

    public struct Videos: Codable {

        public let results: [Results]
    }

    public struct Results: Codable {

        public let id: String
        public let iso6391: String
        public let iso31661: String
        public let key: String
        public let name: String
        public let site: String
        public let size: Int
        public let type: String
    }

    public let adult: Bool
    public let backdropPath: String
    public let belongsToCollection: BelongsToCollection?
    public let budget: Int
    public let genres: [Genres]
    public let homepage: String?
    public let id: Int?
    public let imdbId: String?
    public let originalLanguage: String?
    public let originalTitle: String?
    public let overview: String
    public let popularity: Double?
    public let posterPath: String?
    public let productionCompanies: [ProductionCompanies]?
    public let productionCountries: [ProductionCountries]?
    public let releaseDate: String
    public let revenue: Int?
    public let runtime: Int?
    public let spokenLanguages: [SpokenLanguages]?
    public let status: String?
    public let tagline: String?
    public let title: String
    public let video: Bool
    public let voteAverage: Double?
    public let voteCount: Int?
    public let videos: Videos
}
