//
//  TrailerView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 06/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI

public class ImageLoader: ObservableObject {

    @Published public var data: Data?

    public init(urlString: String) {

        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in // swiftlint:disable:this explicit_type_interface
            guard let data = data else {
                return
            }

            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
