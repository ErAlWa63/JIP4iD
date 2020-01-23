import Foundation

public class NetworkManagerMoviePopular: ObservableObject {

    @Published public var movies: MoviePopular = MoviePopular(page: 0, results: [], totalResults: 0, totalPages: 0) // swiftlint:disable:this redundant_type_annotation unnecessary_type
    @Published public var loading: Bool = true
    private let apiUrlBase: String = "https://api.themoviedb.org/3/movie/popular?api_key=61ef4a247342ea9c8388ef6377a75a24"

    public init() {

        loading = true
        loadData()
    }

    private func loadData() {
        guard let url = URL(string: "\(apiUrlBase)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }

            let decoder: JSONDecoder = JSONDecoder() // swiftlint:disable:this redundant_type_annotation unnecessary_type
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
                let loaded: MoviePopular = try decoder.decode(MoviePopular.self, from: data)
                DispatchQueue.main.async {
                    self.movies = loaded
                    self.loading = false
                }
            } catch let jsonErr { // swiftlint:disable:this explicit_type_interface untyped_error_in_catch
                print("NetworkManagerMoviePopular Error decoding JSON", jsonErr)
            }
            return
        }
        .resume()
    }
}
