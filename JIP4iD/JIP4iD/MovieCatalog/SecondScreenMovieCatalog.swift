//
//  SecondScreenMovieCatalog.swift
//  JIP4iD
//
//  Created by Erik Waterham on 22/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI

public struct SecondScreenMovieCatalog: View {

    public var body: some View {
        WarningView(text: "No movie selected")
    }
}

private struct SecondScreenMovieCatalog_Previews: PreviewProvider {

    static var previews: some View {
        SecondScreenMovieCatalog()
    }
}
