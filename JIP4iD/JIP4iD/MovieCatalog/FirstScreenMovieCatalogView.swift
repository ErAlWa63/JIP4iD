//
//  FirstScreenMovieCatalogView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 22/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI

public struct FirstScreenMovieCatalogView: View {

    @ObservedObject private var networkManager: NetworkManagerMoviePopular = NetworkManagerMoviePopular() // swiftlint:disable:this redundant_type_annotation unnecessary_type
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass // swiftlint:disable:this explicit_type_interface
    @Environment(\.verticalSizeClass) private var verticalSizeClass // swiftlint:disable:this explicit_type_interface

    public var body: some View {
        VStack {
            if networkManager.loading {
                NoDataAvailableView()
            } else {
                List(networkManager.movies.results) { movie in
                    NavigationLink(destination: MovieDetails(id: movie.id)) {
                        self.movieLine("https://image.tmdb.org/t/p/w500\(movie.backdropPath)", movie.title)
                    }
                }
                .environment(\.defaultMinListRowHeight, UIScreen.main.bounds.width * 0.275)
            }
        }
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

    private func movieLine(_ url: String, _ title: String) -> some View {
        GeometryReader { geo in
            self.movieLineItems(geo, url, title)
        }
    }

    private func movieLineItems(_ proxy: GeometryProxy, _ url: String, _ title: String) -> some View {
        HStack(alignment: .center) {
            self.moviePoster(proxy, url)
            self.movieTitle(title)
            Spacer()
        }
    }

    private func moviePoster(_ proxy: GeometryProxy, _ url: String ) -> some View {
        ImageView(withURL: url)
            .frame(width: proxy.size.width / 2, height: proxy.size.height)
            .aspectRatio(contentMode: .fit)
    }

    private func movieTitle( _ title: String) -> some View {
        Text(title)
            .font(.headline)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }

}

private struct FirstScreenMovieCatalogView_Previews: PreviewProvider {

    static var previews: some View {
        FirstScreenMovieCatalogView()
    }
}
