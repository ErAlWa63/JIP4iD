//
//  WebView.swift
//  JIP4iD
//
//  Created by Erik Waterham on 06/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    let url: URL

    public func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }

    public func updateUIView(_ uiView: WKWebView, context: Context) {
        guard context.coordinator.needsToLoadURL else { return }
        uiView.load(URLRequest(url: url))
    }

    public func makeCoordinator() -> WebView.Coordinator {
        Coordinator()
    }

    public class Coordinator {
        var needsToLoadURL = true
    }
}

struct WebKitView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: URL(string: "...")!)
    }
}
