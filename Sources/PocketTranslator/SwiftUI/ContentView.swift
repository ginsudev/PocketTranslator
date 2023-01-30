//
//  ContentView.swift
//  
//
//  Created by Noah Little on 26/1/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            webView
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        menuButton
                        reloadButton
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        closeButton
                    }
                }
                .imageScale(.large)
                .navigationTitle("PocketTranslator")
                .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .scaleEffect(viewModel.isPresented ? 1.0 : 0.0, anchor: .center)
        .animation(.easeInOut(duration: 0.3), value: viewModel.isPresented)
        .onAppear {
            viewModel.isPresented = true
        }
        .onReceive(NotificationCenter.default.publisher(
            for: .init("PocketTranslator.Dismiss")),
            perform: { _ in
                dismissAnimated()
            }
        )
        .ignoresSafeArea()
    }
}

private extension ContentView {
    @ViewBuilder
    var webView: some View {
        if let url = URL(string: viewModel.selectedURLString) {
            WebView(
                url: url,
                isReloading: $viewModel.isReloadingWebView
            )
        }
    }
    
    var menuButton: some View {
        Menu {
            ForEach(
                viewModel.urlStrings.sorted(by: >),
                id: \.key
            ) { key, value in
                Button(key) {
                    viewModel.selectedURLString = value
                }
            }
        } label: {
            Image(systemName: "globe")
        }
    }
    
    var reloadButton: some View {
        Button {
            viewModel.isReloadingWebView = true
        } label: {
            Image(systemName: "arrow.triangle.2.circlepath")
        }
    }

    var closeButton: some View {
        Button {
           dismissAnimated()
        } label: {
            Image(systemName: "xmark")
        }
    }
    
    func dismissAnimated() {
        viewModel.isPresented = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            PTPresentationManager.shared.dismiss()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
