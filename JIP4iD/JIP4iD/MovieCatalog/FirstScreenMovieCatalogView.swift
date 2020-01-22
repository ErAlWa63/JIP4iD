//
//  FirstScreenMovieCatalogView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 22/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI

public struct FirstScreenMovieCatalogView: View {

    @ObservedObject private var networkManager: NetworkManagerMoviePopular = NetworkManagerMoviePopular() // swiftlint:disable:this redundant_type_annotation unnecessary_type

    public var body: some View {
        VStack {
            if networkManager.loading {
                WarningView(text: "Loading movies")
            } else {
                ListMovieCatalogView()
            }
        }
    }
}

private struct FirstScreenMovieCatalogView_Previews: PreviewProvider {

    static var previews: some View {
        FirstScreenMovieCatalogView()
    }
}
