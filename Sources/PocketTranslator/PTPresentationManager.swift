//
//  PTPresentationManager.swift
//  
//
//  Created by Noah Little on 26/1/2023.
//

import UIKit

// MARK: - Public

final class PTPresentationManager {
    static let shared = PTPresentationManager()
    private(set) var window: PTWindow?
    
    private var isPresented: Bool {
        didSet {
            UserDefaults.standard.set(isPresented, forKey: "PocketTranslator.isPresented")
        }
    }
    
    init() {
        isPresented = false
        addObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func present() {
        guard window == nil else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return}
            
            self.isPresented = true
            self.window = self.createWindow()
            self.window!.makeKeyAndVisible()
        }
    }
    
    @objc
    func dismiss() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return}

            self.isPresented = false
            self.window?.isHidden = true
            self.window?.windowScene = nil
            self.window = nil
        }
    }
}

// MARK: - Private

private extension PTPresentationManager {
    func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(present),
            name: .init("PocketTranslator.Present"),
            object: nil
        )
    }
    
    func createWindow() -> PTWindow {
        if #available(iOS 15, *) {
            return PTWindow(
                screen: UIScreen.main,
                role: nil,
                debugName: "PocketTranslator"
            )
        } else {
            return PTWindow(
                screen: UIScreen.main,
                debugName: "PocketTranslator"
            )
        }
    }
}
