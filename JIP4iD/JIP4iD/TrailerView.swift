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

  var body: some View {
    NavigationView {
      WebView(webView: webViewStore.webView)
        .navigationBarTitle(Text(verbatim: webViewStore.webView.title ?? ""), displayMode: .inline)
        .navigationBarItems(trailing: HStack {
          Button(action: goBack) {
            Image(systemName: "chevron.left")
              .imageScale(.large)
              .aspectRatio(contentMode: .fit)
              .frame(width: 32, height: 32)
          }.disabled(!webViewStore.webView.canGoBack)
          Button(action: goForward) {
            Image(systemName: "chevron.right")
              .imageScale(.large)
              .aspectRatio(contentMode: .fit)
              .frame(width: 32, height: 32)
          }.disabled(!webViewStore.webView.canGoForward)
        })
    }.onAppear {
      self.webViewStore.webView.load(URLRequest(url: URL(string: "https://www.youtube.com/embed/t6g0dsQzfqY?autoplay=1")!))
    }
  }

  func goBack() {
    webViewStore.webView.goBack()
  }

  func goForward() {
    webViewStore.webView.goForward()
  }
}
