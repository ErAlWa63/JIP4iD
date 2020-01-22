//
//  MoviePosterView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 22/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI

public struct MoviePosterView: View {

    public var geo: GeometryProxy
    public var url: String

    public var body: some View {
        ImageView(withURL: url)
            .frame(width: geo.size.width / 2, height: geo.size.height)
//            .aspectRatio(contentMode: .fit)
    }

    private func movieTitle( _ title: String) -> some View {
        Text(title)
            .font(.headline)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }
}

// swiftlint:disable comments_space comments_capitalized_find_possible_code
//struct MoviePosterView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoviePosterView()
//    }
//}
