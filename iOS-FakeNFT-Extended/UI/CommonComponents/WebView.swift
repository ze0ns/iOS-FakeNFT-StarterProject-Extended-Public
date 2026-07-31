//
//  WebView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 31.07.2026.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    let url: URL

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        guard context.coordinator.requestedURL != url else { return }
        context.coordinator.requestedURL = url
        webView.load(URLRequest(url: url))
    }

    final class Coordinator {
        var requestedURL: URL?
    }
}

#Preview {
    if let url = URL(string: "https://practicum.yandex.ru") {
        WebView(url: url)
    }
}
