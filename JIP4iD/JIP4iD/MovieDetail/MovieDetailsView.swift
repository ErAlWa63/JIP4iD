import SwiftUI

public struct MovieDetailsView: View {

    @ObservedObject private var networkManager: NetworkManagerMovie = NetworkManagerMovie() // swiftlint:disable:this redundant_type_annotation unnecessary_type
    @State private var showingDetail: Bool = false

    public var id: Int

    public var body: some View {
        VStack {
            if networkManager.loadingMovie {
                WarningView(text: "Loading: Movie Detail")
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

    private func isLandscape() -> Bool {
        UIScreen.main.bounds.width > UIScreen.main.bounds.height
    }

    private func movieButtonTrailer(_ proxy: GeometryProxy, _ isLandscape: Bool, _ videoCount: Int ) -> some View {
        Button(action: { self.showingDetail.toggle() }) { // swiftlint:disable:this multiple_closures_with_trailing_closure
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

    private func movieTrailerView(_ proxy: GeometryProxy, _ key: String ) -> some View {
        TrailerView(key: key)
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
            .aspectRatio(contentMode: .fit)
    }

    private func moviePoster(_ proxy: GeometryProxy, _ isLandscape: Bool, _ url: String ) -> some View {
        ImageView(withURL: url)
            .frame(minWidth: isLandscape ? proxy.size.width / 2 : proxy.size.width, minHeight: proxy.size.height / 3)
            .aspectRatio(contentMode: .fit)
            .padding(.bottom)
    }

    private func movieTitle() -> some View {
        HStack {
            Text(networkManager.movieDetails.title)
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .padding(.bottom)
    }

    private func movieGenres() -> some View {
        VStack {
            HStack {
                Text("Genres")
                    .font(.headline)
                Spacer()
            }
            HStack {
                Text(networkManager.movieDetails.genres.map { $0.name }.joined(separator: ", "))
                    .font(.footnote)
                Spacer()
            }
        }
        .padding(.bottom)
    }

    private func movieReleaseDate() -> some View {
        VStack {
            HStack {
                Text("Date")
                    .font(.headline)
                Spacer()
            }
            HStack {
                Text(networkManager.movieDetails.releaseDate.dottedDate)
                    .font(.footnote)
                Spacer()
            }
        }
        .padding(.bottom)
    }

    private func movieOverview() -> some View {
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
