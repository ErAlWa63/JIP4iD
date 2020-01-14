//
//  ImageView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 09/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    init(withURL url: String) {
        imageLoader = ImageLoader(urlString: url)
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
