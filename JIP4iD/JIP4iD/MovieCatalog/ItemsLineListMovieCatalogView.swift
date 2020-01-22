//
//  ItemsLineListMovieCatalogView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 22/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI

public struct ItemsLineListMovieCatalogView: View {

    public var geo: GeometryProxy
    public var url: String
    public var title: String

    public var body: some View {
        HStack(alignment: .center) {
            self.moviePoster(geo, url)
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

// swiftlint:disable comments_space comments_capitalized_find_possible_code
//struct ItemsLineListMovieCatalogView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemsLineListMovieCatalogView(geo: GeometryProxy(), url: "", title: "title")
//    }
//}
