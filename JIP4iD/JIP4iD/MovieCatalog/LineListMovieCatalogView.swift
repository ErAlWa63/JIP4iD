//
//  LineListMovieCatalogView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 22/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI

public struct LineListMovieCatalogView: View {

    public var url: String
    public var title: String

    public var body: some View {
        GeometryReader { geo in
            self.movieLineItems(geo, self.url, self.title)
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

private struct LineListMovieCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        LineListMovieCatalogView(url: "", title: "title")
    }
}
