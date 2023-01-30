//
//  PTViewController.swift
//  
//
//  Created by Noah Little on 26/1/2023.
//

import UIKit
import PocketTranslatorC

// MARK: - Public

final class PTViewController: SBFTouchPassThroughViewController {
    private let hostingController = LSPresentableHostingController(rootView: ContentView())
    
    override func _canShowWhileLocked() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = nil
        hostingController.view.backgroundColor = nil
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: self,
                action: #selector(didPan(recognizer:))
            )
        )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var frame = hostingController.view.frame
        frame.size.width = self.view.bounds.width * 0.9
        frame.size.height = self.view.bounds.height * 0.7
        hostingController.view.frame = frame
    }
}

// MARK: - Private

private extension PTViewController {
    enum ExceededBounds {
        case left(CGFloat)
        case right(CGFloat)
        case top(CGFloat)
        case bottom(CGFloat)
    }
    
    @objc
    func didPan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)

        hostingController.view.center = CGPoint(
            x: hostingController.view.center.x + translation.x,
            y: hostingController.view.center.y + translation.y
        )
        
        recognizer.setTranslation(.zero, in: self.view)
        
        if recognizer.state == .ended {
            evaluatePosition(forceCenter: false)
        }
    }
    
    /// Checks if the view should be repositioned to fit within bounds.
    func evaluatePosition(forceCenter: Bool) {
        var frame = hostingController.view.frame
        switch exceededBounds() {
        case .left(let x): frame.origin.x = x
        case .right(let x): frame.origin.x = x
        case .top(let y): frame.origin.y = y
        case .bottom(let y): frame.origin.y = y
        default: return
        }
        animateFrameChange(frame: frame)
    }
    
    /// Returns the edge that was exceeded with padding as an associated value.
    func exceededBounds() -> ExceededBounds? {
        let padding = 50.0
        
        if hostingController.view.center.x <= self.view.bounds.minX {
            return .left(self.view.bounds.minX - hostingController.view.frame.width + padding)
        }

        if hostingController.view.center.x >= self.view.bounds.maxX {
            return .right(self.view.bounds.maxX - padding)
        }

        if hostingController.view.center.y <= self.view.bounds.minY {
            return .top(self.view.bounds.minY + (padding * 2))
        }

        if hostingController.view.center.y >= self.view.bounds.maxY {
            return .bottom(self.view.bounds.maxY - hostingController.view.frame.height - (padding * 2))
        }
        
        return nil
    }
    
    /// Changes the frame with an animation.
    func animateFrameChange(frame: CGRect) {
        UIView.animate(
            withDuration: 0.7,
            delay: 0.0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.3
        ) { [weak self] in
            self?.hostingController.view.frame = frame
        }
    }
}
