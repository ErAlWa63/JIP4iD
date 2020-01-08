//
//  TrailerView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 06/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI
import WebKit

struct TrailerView: View {
    @ObservedObject var webViewStore = WebViewStore()
    @Environment(\.presentationMode) var presentationMode

    var key: String

    var body: some View {
        NavigationView {
            WebView(webView: webViewStore.webView)
                .navigationBarTitle(Text(""), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: { self.presentationMode.wrappedValue.dismiss() }) { Text("Done") })
        }
        .onAppear {
            self.webViewStore.webView.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/\(self.key)")!))
        }
    }
}
