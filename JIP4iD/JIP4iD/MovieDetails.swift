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
    @State var showingDetail = false

    var id: Int
    //    var movie: MoviePopular.Results
    var body: some View {
        VStack {
            if networkManager.loadingMovie {
                Text("Loading...")
            } else {

                //        ScrollView {

                GeometryReader { geo in
                    VStack {
                        self.moviePoster("https://image.tmdb.org/t/p/w500\(self.networkManager.movieDetails.backdropPath)")
                        VStack {
                            self.movieTitle()
                            VStack {
                                Button(action: {
                                    self.showingDetail.toggle()
                                }) {
                                    Text("Watch Trailer")}
                                    .frame(width: geo.size.width - 30, height: 40, alignment: .center)
                                    .background(Color("myLightGray"))
                                    .foregroundColor(.black)
                            }
                            .sheet(isPresented: self.$showingDetail) {
//                                TrailerView(item: "P6AaSMfXHbA")
                                TrailerView(key: self.networkManager.movieDetails.videos.results[0].key)
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
            }
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
                print(networkManager.movieDetails.releaseDate)
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let date = dateFormatter.date(from: networkManager.movieDetails.releaseDate)!
                dateFormatter.dateFormat = "dd.MM.yyyy"
        return VStack {
            HStack() {
                Text("Date")
                    .font(.headline)
                Spacer()
            }
            HStack() {
                Text(dateFormatter.string(from: date))
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
