//
//  NetworkManager.swift
//  JIP4iD
//
//  Created by Erik Waterham on 07/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import Foundation

class NetworkManagerMoviePopular: ObservableObject {
    
    @Published var movies = MoviePopular(page: 0, results: [], totalResults: 0, totalPages: 0)
    @Published var loading = true
    private let api_url_base = "https://api.themoviedb.org/3/movie/popular?api_key=61ef4a247342ea9c8388ef6377a75a24"
    init() {
        loading = true
        loadData()
    }

    private func loadData() {
        guard let url = URL(string: "\(api_url_base)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else {
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let loaded = try decoder.decode(MoviePopular.self, from: data)
                DispatchQueue.main.async {
                    self.movies = loaded
                    self.loading = false
                }
            } catch let jsonErr {
                print("NetworkManagerMoviePopular Error decoding JSON", jsonErr)
            }
            return
        }.resume()
    }
}
