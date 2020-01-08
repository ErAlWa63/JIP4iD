//
//  WebViewStore.swift
//  JIP4iD
//
//  Created by Erik Waterham on 08/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import SwiftUI
import Combine
import WebKit

public class WebViewStore: ObservableObject {
  @Published public var webView: WKWebView

  public init(webView: WKWebView = WKWebView()) {
    self.webView = webView
  }
}
