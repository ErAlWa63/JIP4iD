import SwiftUI

public struct ListMovieCatalogView: View {

    @ObservedObject private var networkManager: NetworkManagerMoviePopular = NetworkManagerMoviePopular() // swiftlint:disable:this redundant_type_annotation unnecessary_type
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass // swiftlint:disable:this explicit_type_interface
    @Environment(\.verticalSizeClass) private var verticalSizeClass // swiftlint:disable:this explicit_type_interface

    public var body: some View {
        List(networkManager.movies.results) { movie in
            NavigationLink(destination: MovieDetails(id: movie.id)) {
                LineListMovieCatalogView(url: "https://image.tmdb.org/t/p/w500\(movie.backdropPath)", title: movie.title)
            }
        }
        .environment(\.defaultMinListRowHeight, UIScreen.main.bounds.width * 0.275)
    }

    private func defaultMinListRowHeight() -> CGFloat {
        let isLandscape: Bool = UIScreen.main.bounds.width > UIScreen.main.bounds.height
        guard let localHorizontalSizeClass: UserInterfaceSizeClass = horizontalSizeClass else {
            return 0
        }
        guard let localVerticalSizeClass: UserInterfaceSizeClass = verticalSizeClass else {
            return 0
        }

        switch (localHorizontalSizeClass, localVerticalSizeClass, isLandscape) {
        case (.compact, .regular, false):
            return UIScreen.main.bounds.height * 0.12
        case (.regular, .regular, false):
            return UIScreen.main.bounds.height * 0.12
        case (.compact, .compact, true):
            return UIScreen.main.bounds.height * 0.35
        case (.compact, .regular, true):
            return UIScreen.main.bounds.height * 0.15
        case (.regular, .compact, true):
            return UIScreen.main.bounds.height * 0.2
        case (.regular, .regular, true):
            return UIScreen.main.bounds.height * 0.12
        default:
            return 0
        }
    }

}

private struct ListMovieCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        ListMovieCatalogView()
    }
}
