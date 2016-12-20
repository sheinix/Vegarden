//
//  Zoomable.swift
//  Vegarden
//
//  Created by Sarah Cleland on 20/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import UIKit


public protocol LongPresseable : class {
    
}

extension LongPresseable where Self : UIView {
   
    func makeMeLongPresseableWith(action: Selector) -> UILongPressGestureRecognizer {
    
        let longPress = UILongPressGestureRecognizer()
        longPress.allowableMovement = CGFloat(integerLiteral: 80)
        longPress.minimumPressDuration = CFTimeInterval(floatLiteral: 1.0)
        longPress.numberOfTapsRequired = 0
        longPress.numberOfTouchesRequired = 1
        longPress.addTarget(self, action:action)
        
        self.addGestureRecognizer(longPress)
        
        return longPress
    }
}

public protocol Zoomeable : class {
    
    //func zoomIn()
}

extension Zoomeable where Self : UIView {
    
//    func zoomIn() {
//        
//        //Weird check: At runtime if conforms to longpress aswell?
//        guard let _ = self as? LongPresseable else { return }
//        
//        let selector = UIView.animate(withDuration: 0.6,
//                       animations: { self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6) },
//                       completion: { (finish: Bool) in UIView.animate(withDuration: 0.6,
//                                                                      animations: { self.transform =
//                                                                        CGAffineTransform.identity }) })
//        
//        self.
//        
//    }
    
    
}
