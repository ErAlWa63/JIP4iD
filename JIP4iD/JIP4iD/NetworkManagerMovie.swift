//
//  NetworkManagerMovie.swift
//  JIP4iD
//
//  Created by Erik Waterham on 07/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import Foundation
import Combine

class NetworkManagerMovie: ObservableObject {
    @Published var movies = MoviePopular(page: 0, results: [], totalResults: 0, totalPages: 0)
    @Published var loading = false
    private var id: Int
    private let apiUrlBaseBegin = "https://api.themoviedb.org/3/movie/"
    private let apiUrlBaseEnd = "?api_key=61ef4a247342ea9c8388ef6377a75a24&append_to_response=videos"
    init(id: Int) {
        self.id = id
        loading = true
        loadData()
    }

    private func loadData() {
        guard let url = URL(string: "\(apiUrlBaseBegin)\(id)\(apiUrlBaseEnd)") else { return }
        print(url)
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let loaded = try decoder.decode(MoviePopular.self, from: data)
                DispatchQueue.main.async {
                    self.movies = loaded
                    self.loading = false
                    print(loaded)
                }
            } catch let jsonErr {
                print("Error decoding JSON", jsonErr)
            }
            return
        }.resume()
    }
}
