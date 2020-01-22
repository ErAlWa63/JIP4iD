//
//  MovieCatalogView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 14/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI

public struct MovieCatalogView: View {

    public var body: some View {
        NavigationView {
            FirstScreenMovieCatalogView()
            .navigationBarTitle("Movie Catalog", displayMode: .inline)

            SecondScreenMovieCatalog()
        }
    }
}

private struct MovieCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCatalogView()
    }
}
