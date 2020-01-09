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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State private var selectedView: Int? = 0

    var body: some View {
        NavigationView {
            VStack {
                if networkManager.loading {
                    Text("Loading...")
                } else {
                    List(networkManager.movies.results) { movie in
                        NavigationLink(destination: MovieDetails(id: movie.id), tag: movie.id, selection: self.$selectedView) {
                            self.movieLine("https://image.tmdb.org/t/p/w500\(movie.backdropPath)", movie.title)
                        }
                    }
                    .onAppear{
                        let device = UIDevice.current
                        if device.model == "iPad" && UIScreen.main.bounds.width > UIScreen.main.bounds.height {
                            self.selectedView = 1
                        } else {
                            self.selectedView = 0
                        }
                        print("self.selectedView = \(self.selectedView)")
                        print("UIScreen.main.bounds = \(UIScreen.main.bounds)")
                        print(UIScreen.screens.count)

                    }
//                    .environment(\.defaultMinListRowHeight, sizeClass == .compact ? 200 : UIScreen.main.bounds.height / 7)
//                    .environment(\.defaultMinListRowHeight, sizeClass == .compact ? UIScreen.main.bounds.width * 3 / 10 : UIScreen.main.bounds.height / 7)
                    .environment(\.defaultMinListRowHeight, defaultMinListRowHeight())
                }
            }
            .navigationBarTitle("Movie Catalog", displayMode: .inline)

            Text("No movie selected!\nRotate screen to landscape to select a movie!\nOr swipe from left to richt on left border of screen!")
                .font(.title)
                .foregroundColor(.red)
        }
    }

    func defaultMinListRowHeight() -> CGFloat {
        print("horizontalSizeClass = \(horizontalSizeClass!), verticalSizeClass = \(verticalSizeClass!)")
        print("UIScreen.main.bounds = \(UIScreen.main.bounds)")
        let isLandscape = UIScreen.main.bounds.width > UIScreen.main.bounds.height
        print("isLandscape = \(isLandscape)")

        switch (horizontalSizeClass, verticalSizeClass, isLandscape) {
        case (.compact, .compact, false): return  0
        case (.compact, .regular, false): return UIScreen.main.bounds.height * 0.12
        case (.regular, .compact, false): return  0
        case (.regular, .regular, false): return UIScreen.main.bounds.height * 0.12
        case (.compact, .compact, true): return  0
        case (.compact, .regular, true): return UIScreen.main.bounds.height * 0.15
        case (.regular, .compact, true): return UIScreen.main.bounds.height * 0.2
        case (.regular, .regular, true): return UIScreen.main.bounds.height * 0.12
        default: return 0
        }
    }

    func movieLine(_ url: String, _ title: String) -> some View {
        GeometryReader { geo in
            self.movieLineItems(geo, url, title)
        }

    }

    func movieLineItems(_ proxy: GeometryProxy, _ url: String, _ title: String) -> some View {
        print(proxy.size)
        print(UIScreen.main.bounds)
        print(UIScreen.screens.count)
        return HStack(alignment: .center) {
            self.moviePoster(proxy, url)
            self.movieTitle(title)
            Spacer()
        }
    }

    func moviePoster(_ proxy: GeometryProxy, _ url: String ) -> some View {
        ImageView(withURL: url)
//            .frame(width: proxy.size.width/2, height: UIDevice.current.orientation.isLandscape ? proxy.size.width : proxy.size.height / 3)
            .frame(width: proxy.size.width/2, height: proxy.size.height)
            .aspectRatio(contentMode: .fit)
//        .clipped()
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
