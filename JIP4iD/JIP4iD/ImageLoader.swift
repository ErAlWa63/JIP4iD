//
//  TrailerView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 06/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import Combine
import SwiftUI

public class ImageLoader: ObservableObject {

    public var dataPublisher: PassthroughSubject = PassthroughSubject<Data, Never>() // swiftlint:disable:this unnecessary_type

    private var data: Data = Data() { // swiftlint:disable:this redundant_type_annotation unnecessary_type
        didSet {
            dataPublisher.send(data)
        }
    }

    public init(urlString: String) {

        guard let url = URL(string: urlString) else {
            return
        }

        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
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
