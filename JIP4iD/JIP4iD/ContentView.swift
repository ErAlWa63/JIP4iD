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
    }
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image(uiImage: self.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
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
    
    var body: some View {
        NavigationView {
            VStack {
                if networkManager.loading {
                    Text("Loading...")
                } else {
                    List(networkManager.movies.results) { movie in
                        NavigationLink(destination: MovieDetails(movie: movie)) {
                            GeometryReader { geo in
                                HStack(alignment: .center) {
                                    ImageView(withURL: "https://image.tmdb.org/t/p/w500\(movie.backdropPath)")
                                        .frame(width: geo.size.width/2, height: geo.size.height/2)
                                        .scaledToFill()
                                        .scaleEffect(2.0)
                                    Text("\(movie.title)")
                                        .font(.headline)
                                        .lineLimit(nil)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .environment(\.defaultMinListRowHeight, 100)
                    .navigationBarTitle("Movie Catalog", displayMode: .inline)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
