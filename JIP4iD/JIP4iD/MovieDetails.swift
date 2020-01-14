//
//  MovieDetails.swift
//  JIP4iD
//
//  Created by Erik Waterham on 07/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI

struct MovieDetails: View {
    
    @ObservedObject var networkManager = NetworkManagerMovie()
    @State var showingDetail = false

    var id: Int

    var body: some View {
        VStack {
            if networkManager.loadingMovie {
                Text("Loading...")
            } else {
                if isLandscape() {
                    GeometryReader { geo in
                        VStack {
                            HStack {
                                VStack {
                                    self.moviePoster(geo, self.isLandscape(), "https://image.tmdb.org/t/p/w500\(self.networkManager.movieDetails.backdropPath)")
                                    VStack {
                                        self.movieGenres()
                                        self.movieReleaseDate()
                                        self.movieOverview()
                                        Spacer()
                                    }
                                    .padding([.leading, .trailing])
                                }
                                VStack {
                                    self.movieTitle()
                                    self.movieButtonTrailer(geo, self.isLandscape(), self.networkManager.movieDetails.videos.results.count)
                                    Spacer()
                                }
                                .padding([.leading, .trailing])
                            }
                            .frame(width: geo.size.width, height: geo.size.height)
                        }
                        .navigationBarTitle(Text("Movie Detail"), displayMode: .inline)
                        .padding()
                    }
                } else {
                    GeometryReader { geo in
                        VStack {
                            self.moviePoster(geo, self.isLandscape(), "https://image.tmdb.org/t/p/w500\(self.networkManager.movieDetails.backdropPath)")
                            VStack {
                                self.movieTitle()
                                self.movieButtonTrailer(geo, self.isLandscape(), self.networkManager.movieDetails.videos.results.count)
                                self.movieGenres()
                                self.movieReleaseDate()
                                self.movieOverview()
                                Spacer()
                            }
                            .padding([.leading, .trailing])
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                        .navigationBarTitle(Text("Movie Detail"), displayMode: .inline)
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            self.networkManager.loadData(self.id)
        }
    }

    func isLandscape() -> Bool {
        UIScreen.main.bounds.width > UIScreen.main.bounds.height
    }

    func movieButtonTrailer(_ proxy: GeometryProxy, _ isLandscape: Bool, _ videoCount: Int ) -> some View {
        Button(action: { self.showingDetail.toggle() }) {
            if videoCount == 0 {
                Text("No Trailer")
            } else {
                Text("Watch Trailer")

            }
        }
        .frame(width: isLandscape ? (proxy.size.width - 60) / 2 : proxy.size.width, height: 40, alignment: .center)
        .background(Color("myLightGray"))
        .foregroundColor(.black)
        .disabled(videoCount == 0)
        .sheet(isPresented: self.$showingDetail) {
            self.movieTrailerView(proxy, self.networkManager.movieDetails.videos.results[0].key)
        }
        .padding(.bottom)
    }

    func movieTrailerView(_ proxy: GeometryProxy, _ key: String ) -> some View {
        TrailerView(key: key)
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
            .aspectRatio(contentMode: .fit)
    }

    func moviePoster(_ proxy: GeometryProxy, _ isLandscape: Bool, _ url: String ) -> some View {
        ImageView(withURL: url)
            .frame(minWidth: isLandscape ? proxy.size.width / 2 : proxy.size.width, minHeight: proxy.size.height/3)
            .aspectRatio(contentMode: .fit)
            .padding(.bottom)
    }

    func movieTitle() -> some View {
        HStack {
            Text(networkManager.movieDetails.title)
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .padding(.bottom)
    }

    func movieGenres() -> some View {
        VStack {
            HStack {
                Text("Genres")
                    .font(.headline)
                Spacer()
            }
            HStack {
                Text(networkManager.movieDetails.genres.map{$0.name}.joined(separator: ", "))
                    .font(.footnote)
                Spacer()
            }
        }
        .padding(.bottom)
    }

    func movieReleaseDate() -> some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: networkManager.movieDetails.releaseDate)!
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return VStack {
            HStack {
                Text("Date")
                    .font(.headline)
                Spacer()
            }
            HStack {
                Text(dateFormatter.string(from: date))
                    .font(.footnote)
                Spacer()
            }
        }
        .padding(.bottom)
    }

    func movieOverview() -> some View {
        VStack {
            HStack {
                Text("Overview")
                    .font(.headline)
                Spacer()
            }
            HStack {
                Text(networkManager.movieDetails.overview)
                    .font(.footnote)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
        }
        .padding(.bottom)
    }
}
