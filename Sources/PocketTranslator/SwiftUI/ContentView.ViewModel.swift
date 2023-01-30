//
//  ContentView.ViewModel.swift
//  
//
//  Created by Noah Little on 26/1/2023.
//

import Foundation

extension ContentView {
    final class ViewModel: ObservableObject {
        let urlStrings: [String: String] = [
            "Google": "https://translate.google.com",
            "BaiDu": "https://fanyi.baidu.com/",
            "DeepL": "https://deepl.com/",
            "Bing": "https://www.bing.com/translator"
        ]
        
        @Published var selectedURLString = UserDefaults.standard.string(forKey: "PocketTranslator.selectedURLString") ?? "https://translate.google.com" {
            didSet {
                UserDefaults.standard.set(selectedURLString, forKey: "PocketTranslator.selectedURLString")
            }
        }
        
        @Published var isPresented = false
        @Published var isReloadingWebView = false
    }
}
