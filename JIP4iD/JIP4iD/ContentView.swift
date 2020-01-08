//
//  ContentView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 06/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI
import Foundation
import Combine

class ImageLoader: ObservableObject {
    var dataPublisher = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            dataPublisher.send(data)
        }
    }
    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
        print(url)
    }
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image(uiImage: self.image)
                    .resizable()
            }.onReceive(self.imageLoader.dataPublisher) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
    }
}
struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(withURL: "")
    }
}

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManagerMoviePopular()
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        NavigationView {
            VStack {
                if networkManager.loading {
                    Text("Loading...")
                } else {
                    List(networkManager.movies.results) { movie in
                        NavigationLink(destination: MovieDetails(movie: movie)) {
                            self.movieLine("https://image.tmdb.org/t/p/w500\(movie.backdropPath)", movie.title)
                        }
                    }
                    .environment(\.defaultMinListRowHeight, sizeClass == .compact ? UIScreen.main.bounds.width * 3 / 10 : UIScreen.main.bounds.height / 2)
                }
            }
            .navigationBarTitle("Movie Catalog", displayMode: .inline)
        }
    }

    func movieLine(_ url: String, _ title: String) -> some View {
        GeometryReader { geo in
            self.movieLineItems(geo, url, title)
        }

    }

    func movieLineItems(_ proxy: GeometryProxy, _ url: String, _ title: String) -> some View {
        HStack(alignment: .center) {
            self.moviePoster(proxy, url)
            self.movieTitle(title)
            Spacer()
        }
    }

    func moviePoster(_ proxy: GeometryProxy, _ url: String ) -> some View {
        ImageView(withURL: url)
            .frame(width: proxy.size.width/2, height: proxy.size.height)
            .aspectRatio(contentMode: .fit)
    }

    func movieTitle( _ title: String) -> some View {
        Text(title)
            .font(.headline)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
