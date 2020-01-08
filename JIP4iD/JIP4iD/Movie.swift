//
//  Movie.swift
//  JIP4iD
//
//  Created by Erik Waterham on 08/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

struct Movie: Codable {
    struct BelongsToCollection: Codable, Identifiable {
        let id: Int
        let name: String
        let posterPath: String
        let backdropPath: String
    }
    struct Genres: Codable, Identifiable {
        let id : Int
        let name : String
    }
    struct ProductionCompanies: Codable, Identifiable {
        let id : Int
        let logoPath : String?
        let name : String
        let originCountry : String
    }
    struct ProductionCountries: Codable {
        let iso31661 : String
        let name : String
    }
    struct SpokenLanguages: Codable {
        let iso_639_1 : String?
        let name : String?
    }
    struct Videos: Codable {
        struct Results: Codable {
            let id : String
            let iso6391 : String
            let iso31661 : String
            let key : String
            let name : String
            let site : String
            let size : Int
            let type : String
        }
        let results : [Results]
    }
    let adult : Bool
    let backdropPath : String
    let belongsToCollection : BelongsToCollection?
    let budget : Int
    let genres : [Genres]
    let homepage : String?
    let id : Int?
    let imdbId : String?
    let originalLanguage : String?
    let originalTitle : String?
    let overview : String
    let popularity : Double?
    let posterPath : String?
    let productionCompanies : [ProductionCompanies]?
    let productionCountries : [ProductionCountries]?
    let releaseDate : String
    let revenue : Int?
    let runtime : Int?
    let spokenLanguages : [SpokenLanguages]?
    let status : String?
    let tagline : String?
    let title : String
    let video : Bool?
    let voteAverage : Double?
    let voteCount : Int?
    let videos : Videos
}
