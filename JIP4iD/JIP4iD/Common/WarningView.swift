//
//  WarningView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 22/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI

public struct WarningView: View {

    public var text: String = "WarningView"

    public var body: some View {
        Text(text)
            .font(.title)
    }
}

private struct WarningView_Previews: PreviewProvider {

    static var previews: some View {
        WarningView(text: "WarningView")
    }
}
