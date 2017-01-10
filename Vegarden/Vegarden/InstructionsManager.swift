//
//  InstructionsManager.swift
//  Vegarden
//
//  Created by Sarah Cleland on 9/01/17.
//  Copyright © 2017 Juan Nuvreni. All rights reserved.
//

import Foundation



protocol InstructionsDelegate: class {
    
    
}


private let sharedInstructionsManager = InstructionsManager()

class InstructionsManager {
    
    class var shared: InstructionsManager {
        
        return sharedInstructionsManager
    }
    
    weak var delegate: InstructionsDelegate?
       
    public func animate(gesture: gestureTypes, in point: CGPoint, of screen: UIView) {
        
        if !UserDefaults.isFirstLaunch() { return }
        
        let frame = CGRect(x: point.x, y: point.y, width: 250, height: 250)
        
        let gesture = GestureInstructionView(frame: frame, gestType : gesture)
        
        gesture.delegate = self
        
        screen.addSubview(gesture)
        
        gesture.animateGesture()
        
    }
}
extension InstructionsManager : GestureInstructionViewDelegate {
    
    func animationDidFinish(animationView: GestureInstructionView) {
        
        
        
    }
    
}
