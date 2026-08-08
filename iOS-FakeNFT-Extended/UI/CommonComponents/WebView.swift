//
//  WebView.swift
//  iOS-FakeNFT-Extended
//
//  Created by Kirill Efremov on 31.07.2026.
//

import SwiftUI
import WebKit

struct WebView: View {

    let url: URL

    @State private var isLoading = true

    var body: some View {
        Representable(url: url, isLoading: $isLoading)
            .overlay {
                if isLoading {
                    ProgressView()
                }
            }
    }

    private struct Representable: UIViewRepresentable {

        let url: URL

        @Binding var isLoading: Bool

        func makeCoordinator() -> Coordinator {
            Coordinator(isLoading: $isLoading)
        }

        func makeUIView(context: Context) -> WKWebView {
            let webView = WKWebView()
            webView.navigationDelegate = context.coordinator
            return webView
        }

        func updateUIView(_ webView: WKWebView, context: Context) {
            guard context.coordinator.requestedURL != url else { return }
            context.coordinator.requestedURL = url
            webView.load(URLRequest(url: url))
        }

        final class Coordinator: NSObject, WKNavigationDelegate {

            var requestedURL: URL?

            @Binding private var isLoading: Bool

            init(isLoading: Binding<Bool>) {
                _isLoading = isLoading
            }

            func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
                isLoading = true
            }

            func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
                isLoading = false
            }

            func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
                isLoading = false
            }

            func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
                isLoading = false
            }
        }
    }
}

#Preview {
    if let url = URL(string: "https://practicum.yandex.ru") {
        WebView(url: url)
    }
}
