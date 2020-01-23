import SwiftUI
import WebKit

public class WebViewStore: ObservableObject {

  @Published public var webView: WKWebView

  public init(webView: WKWebView = WKWebView()) {
    self.webView = webView
  }
}
