//
//  ImageView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 09/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI

public struct ImageView: View {

    @ObservedObject private var imageLoader: ImageLoader

    @State private var image: UIImage = UIImage() // swiftlint:disable:this redundant_type_annotation unnecessary_type

    public init(withURL url: String) {

        imageLoader = ImageLoader(urlString: url)
    }

    public var body: some View {
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

private struct ImageView_Previews: PreviewProvider {

    static var previews: some View {
        ImageView(withURL: "")
    }
}
