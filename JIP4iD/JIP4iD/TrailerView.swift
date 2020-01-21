//
//  TrailerView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 06/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI
import WebKit

public struct TrailerView: View {

    @ObservedObject private var webViewStore: WebViewStore = WebViewStore() // swiftlint:disable:this redundant_type_annotation
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    public var key: String

    public var body: some View {
        NavigationView {
            VStack {
                WebView(url: URL(string: "https://www.youtube.com/embed/\(self.key)")!) // swiftlint:disable:this force_unwrapping
                Spacer()
            }
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) { //swiftlint:disable:this multiple_closures_with_trailing_closure
                Text("Done")
            })
        }
        .onAppear {
            self.webViewStore.webView.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/\(self.key)")!)) // swiftlint:disable:this force_unwrapping
        }
    }
}
