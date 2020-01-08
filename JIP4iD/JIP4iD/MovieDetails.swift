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
    @ObservedObject var networkManager = NetworkManagerMovie()

    var id: Int
//    var movie: MoviePopular.Results
    var body: some View {
//        ScrollView {
        GeometryReader { geo in
            VStack {
//                ImageView(withURL: "https://image.tmdb.org/t/p/w500\(self.movie.backdropPath)")
//                    .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height/3)
//                    .scaledToFit()
//                    .background(Color.red)
//                HStack {
//                    Text("\(self.movie.title)")
//                        .font(.title)
//                        .lineLimit(nil)
//                        .multilineTextAlignment(.leading)
//                    Spacer()
//                }
                Button(action: {}) {Text("Watch Trailer")}
                    .frame(width: geo.size.width - 30, height: 40, alignment: .center)
                    .background(Color("myLightGray"))
                .foregroundColor(.black)
                HStack {
                    Text("Genres")
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text("Action, Thriller and Science Fiction")
                    Spacer()
                }
                HStack {
                    Text("Date")
                        .font(.headline)
                    Spacer()
                }
                Text("27.04.2016")
//                Text(self.movie.overview).lineLimit(nil)
                Spacer()
            }.navigationBarTitle(Text("Movie Detail"), displayMode: .inline)
                .padding()
        }
        .onAppear {
            self.networkManager.loadData(self.id)
            
        }
//        }
    }

}
