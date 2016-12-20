//
//  ZoomView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 20/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit


class ZoomView: UIView, LongPresseable {

 
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        let gesture = self.makeMeLongPresseableWith(action: #selector(zoomIn))
        gesture.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    

    @objc func zoomIn() {
        
        guard let superView = self.superview else { return }
        
        let backgroundView = UIView(frame: CGRect(x:0, y:0, width: screenWidth, height: screenHeight))
        backgroundView.addBlurEffect(style: .dark)
        backgroundView.clipsToBounds = false
        self.clipsToBounds = false
        
        superView.insertSubview(backgroundView, belowSubview: self)
        
    
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        
                        self.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                        self.center = screenCenter
                        
                        
                        },
                       completion: { (finish: Bool) in })
        
        
//        UIView.animate(withDuration: 0.6,
//                       animations: {
//                        self.transform = CGAffineTransform.identity
//                        superView.removeVisualEffects()
    }
}

extension ZoomView : UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        return true
    }
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
