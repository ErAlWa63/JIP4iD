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
                self.moviePoster("https://image.tmdb.org/t/p/w500\(self.networkManager.movieDetails.backdropPath)")
                VStack {
                self.movieTitle()
                VStack {
                    Button(action: {}) {Text("Watch Trailer")}
                        .frame(width: geo.size.width - 30, height: 40, alignment: .center)
                        .background(Color("myLightGray"))
                        .foregroundColor(.black)
                }
                .padding(.bottom)
                self.movieGenres()
                self.movieReleaseDate()
                self.movieOverview()
                }
                .padding([.leading, .trailing])
                Spacer()
            }.navigationBarTitle(Text("Movie Detail"), displayMode: .inline)
                .padding()
        }
        .onAppear {
            self.networkManager.loadData(self.id)
        }
    }

    func moviePoster(_ url: String ) -> some View {
        ImageView(withURL: url)
            .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height/3)
            .aspectRatio(contentMode: .fit)
            .padding(.bottom)
    }



    func movieTitle() -> some View {
        HStack() {
            Text(networkManager.movieDetails.title)
                .font(.headline)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding(.bottom)
    }

    func movieGenres() -> some View {
        VStack {
            HStack() {
                Text("Genres")
                    .font(.headline)
                Spacer()
            }
            HStack() {
                Text(networkManager.movieDetails.genres.map{$0.name}.joined(separator: ", "))
                    .font(.footnote)
                Spacer()
            }
        }
        .padding(.bottom)
    }

    func movieReleaseDate() -> some View {
        VStack {
            HStack() {
                Text("Date")
                    .font(.headline)
                Spacer()
            }
            HStack() {
                Text(networkManager.movieDetails.releaseDate)
                    .font(.footnote)
                Spacer()
            }
        }
        .padding(.bottom)
    }

    func movieOverview() -> some View {
        VStack {
            HStack() {
                Text("Overview")
                    .font(.headline)
                Spacer()
            }
            HStack() {
                Text(networkManager.movieDetails.overview)
                    .font(.footnote)
                Spacer()
            }
        }
        .padding(.bottom)
    }
}
