//
//  GestureInstructionView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 9/01/17.
//  Copyright © 2017 Juan Nuvreni. All rights reserved.
//

import UIKit
import Foundation
import SnapKit



protocol GestureInstructionViewDelegate: class {
    
    func animationDidFinish(animationView: GestureInstructionView)
    
}

public enum gestureTypes : Int  {
    case swipeRight = 0, swipeDown
    
    public var keyForGesture : String! {
        switch self {
        case .swipeDown:
            return UserDefaultsKeys.swipeDownKey
        case .swipeRight:
            return UserDefaultsKeys.swipeRightKey

        }
    }
}


class GestureInstructionView: UIView {

    var gestureType: gestureTypes!
    
    var messageLabel: UILabel!
    var imageGesture: UIImageView!
    
    var animationFrom : CGPoint?
    var animationTo : CGPoint?
    
    weak var delegate: GestureInstructionViewDelegate?
    
    convenience init(frame: CGRect, gestType : gestureTypes) {
        
        self.init(frame: frame)
    
        self.gestureType = gestType
        
        setupViews()
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

    
    fileprivate func setupViews() {
        
        imageGesture = imageFor(gesture: gestureType)
        messageLabel = labelFor(gesture: gestureType)
        
        addSubview(imageGesture)
        addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(-70)
            make.width.equalTo(screenWidth)
            make.height.greaterThanOrEqualTo(50)
        }
        
        imageGesture.frame = CGRect(x: 0, y: 0, width: self.imageGesture.frame.width, height: self.imageGesture.frame.height)
    }

    
    fileprivate func labelFor(gesture: gestureTypes) -> UILabel? {
        
        self.messageLabel = UILabel(frame: self.frame)
        self.messageLabel.sizeToFit()
        self.messageLabel.textAlignment = .left
        self.messageLabel.lineBreakMode = .byWordWrapping
        self.messageLabel.numberOfLines = 0
        self.messageLabel.textColor = UIColor.darkText
        self.messageLabel.font = Fonts.instructionFont
        
        
        switch gesture {
            case .swipeRight:
            
                self.messageLabel.text = "Swipe Right to show menu"
            case .swipeDown:
                self.messageLabel.text = "Swipe down and release to go back"
            }
        
        return self.messageLabel
    }
    
    fileprivate func imageFor(gesture: gestureTypes) -> UIImageView {
        
        let frame = UIEdgeInsetsInsetRect(self.frame, UIEdgeInsets(top: 0, left: 80, bottom: -25, right: -80))
        
        let imgView = UIImageView(frame: frame)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        
        switch gesture {
        case .swipeRight:
            imgView.image = UIImage(named:"swipeRight")
        case .swipeDown:
            imgView.image = UIImage(named:"swipeDown")

        }
        
        return imgView
    }
    
    fileprivate func setFromAndToAnimation() {
    
        guard let img = self.imageGesture else { return }
        
        if self.gestureType == .swipeRight {
            
            animationFrom = CGPoint(x: -img.frame.width/2, y: 0)
            animationTo = CGPoint(x: self.frame.size.width/2, y: 0)

        } else if self.gestureType == .swipeDown {
            
            animationFrom = CGPoint(x: 0, y: frame.origin.y)
            animationTo = CGPoint(x: 0, y: frame.size.height + img.frame.height)
        }
        
    
    }
    
    public func animateGesture() {

        setFromAndToAnimation()
       
        UIView.animate(withDuration: 2.5, delay: 1.0, options: [.curveEaseOut], animations: {
                
                if (self.gestureType == .swipeRight) {
                    self.imageGesture.frame.origin.x = (self.animationFrom?.x)!
                    self.imageGesture.frame.origin.x = (self.animationTo?.x)!
                    
                } else if (self.gestureType == .swipeDown) {
                    self.imageGesture.frame.origin.y = (self.animationFrom?.y)!
                    self.imageGesture.frame.origin.y = (self.animationTo?.y)!
                    
                }
                self.imageGesture.alpha = 0
                self.messageLabel.alpha = 0
            
            }, completion: { (succes) in
                
                if (succes) {
                    self.removeFromSuperview()
                    self.delegate?.animationDidFinish(animationView: self)
                }
            })
    }
}
