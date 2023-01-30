//
//  WebView.swift
//  
//
//  Created by Noah Little on 26/1/2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    @Binding var isReloading: Bool

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(
        _ webView: WKWebView,
        context: Context
    ) {
        let request = URLRequest(url: url)
        webView.load(request)
        if isReloading {
            DispatchQueue.main.async {
                self.isReloading = false
            }
        }
    }
}
