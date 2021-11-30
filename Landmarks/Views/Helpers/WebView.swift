import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding var htmlString: String
    @Binding var baseURL: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.frame.size.height = 1
        webView.frame.size = webView.scrollView.contentSize
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if self.htmlString != context.coordinator.lastLoadedHTML {
            context.coordinator.lastLoadedHTML = self.htmlString
            uiView.loadHTMLString(self.htmlString, baseURL: self.baseURL)
            uiView.frame.size.height = 1
            uiView.frame.size = uiView.scrollView.contentSize
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: WebView
        var lastLoadedHTML = ""
        
        // Empty but useful for when you need a navigation or ui delegate

        init(_ parent: WebView) {
            self.parent = parent
        }
    }
}

