import SwiftUI

public struct FirstScreenMovieCatalogView: View {

    @ObservedObject private var networkManager: NetworkManagerMoviePopular = NetworkManagerMoviePopular() // swiftlint:disable:this redundant_type_annotation unnecessary_type

    public var body: some View {
        VStack {
            if networkManager.loading {
                WarningView(text: "Loading: Movie Catalog")
            } else {
                GeometryReader { geo in
                    ListMovieCatalogView(geo: geo)
                }
            }
        }
    }
}

private struct FirstScreenMovieCatalogView_Previews: PreviewProvider {

    static var previews: some View {
        FirstScreenMovieCatalogView()
    }
}
