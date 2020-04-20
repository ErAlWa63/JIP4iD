import SwiftUI

public struct ListMovieCatalogView: View {

    public var geo: GeometryProxy

    @ObservedObject private var networkManager: NetworkManagerMoviePopular = NetworkManagerMoviePopular() // swiftlint:disable:this redundant_type_annotation unnecessary_type

    private var defaultMinListRowHeight: CGFloat {

        geo.size.width * 0.28
    }

    public var body: some View {
        List(networkManager.movies.results) { movie in
            NavigationLink(destination: MovieDetailsView(id: movie.id)) {
                LineListMovieCatalogView(url: "https://image.tmdb.org/t/p/w500\(movie.posterPath)", title: movie.title)
            }
        }
        .environment(\.defaultMinListRowHeight, defaultMinListRowHeight)
    }
}

// swiftlint:disable comments_space comments_capitalized_find_possible_code
//private struct ListMovieCatalogView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListMovieCatalogView(geo: geo)
//    }
//}
