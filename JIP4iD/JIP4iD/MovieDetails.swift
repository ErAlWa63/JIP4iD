//
//  MovieDetails.swift
//  JIP4iD
//
//  Created by Erik Waterham on 07/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

//import Foundation
import SwiftUI
//import URLImage
let BASE_IMAGE_URL = "https://image.tmdb.org/t/p/original/"
struct MovieDetails : View {
    var movie: MoviePopular.Results
    var body: some View {
        GeometryReader { geo in
            VStack {
                ImageView(withURL: "https://image.tmdb.org/t/p/w500\(self.movie.backdropPath)")
                    .frame(width: geo.size.width/2, height: geo.size.height/2)
                    .scaledToFill()
                    .scaleEffect(2.0)
                HStack {
                    Text("Description").foregroundColor(.gray)
                    Spacer()
                }
                Text(self.movie.overview).lineLimit(nil)
                Spacer()
            }.navigationBarTitle(Text("Movie Detail"), displayMode: .inline)
                .padding()
        }
    }
}
