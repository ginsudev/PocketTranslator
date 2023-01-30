//
//  PTWindow.swift
//  
//
//  Created by Noah Little on 26/1/2023.
//

import Foundation
import PocketTranslatorC

class PTWindow: SBFTouchPassThroughWindow {
    
    @available(iOS, deprecated: 15)
    override init!(
        screen arg1: UIScreen!,
        debugName arg2: String!
    ) {
        super.init(
            screen: arg1,
            debugName: arg2
        )
        commonInit()
    }
    
    override init!(
        screen arg0: Any!,
        role arg1: Any!,
        debugName arg2: Any!
    ) {
        super.init(
            screen: arg0,
            role: arg1,
            debugName: arg2
        )
        commonInit()
    }
    
    private func commonInit() {
        //Allow this window to show when the device is locked.
        _setSecure(true)
        //Set the window level to be higher than everything else.
        windowLevel = .statusBar + 99999999
        //Set our custom touch pass through controller as the root vc.
        rootViewController = PTViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
}
