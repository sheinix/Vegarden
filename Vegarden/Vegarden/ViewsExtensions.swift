//
//  ViewsExtensions.swift
//  Vegarden
//
//  Created by Sarah Cleland on 16/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField

extension SkyFloatingLabelTextField {
    
    func setupPatchEditionTextView() {
        
        self.tintColor = UIColor.lightText
        self.textColor = UIColor.darkGray
        self.lineColor = UIColor.lightGray
        self.selectedTitleColor = Colors.mainColorUI
        self.selectedLineColor = Colors.mainColorUI
        
        self.lineHeight = 1.0 // bottom line height in points
        self.selectedLineHeight = 2.0
        
        
    }
    
}
extension UITextField {
    
    func hasOnlyNumbers() -> Bool {
        // Create an `NSCharacterSet` set which includes everything *but* the digits
        let inverseSet = NSCharacterSet(charactersIn:"0123456789.,").inverted
        
        // At every character in this "inverseSet" contained in the string,
        // split the string up into components which exclude the characters
        // in this inverse set
        let components = self.text?.components(separatedBy: inverseSet)
        
        // Rejoin these components
        let filtered = components?.joined(separator: "")  // use join("", components) if you are using Swift 1.2
        
        // If the original string is equal to the filtered string, i.e. if no
        // inverse characters were present to be eliminated, the input is valid
        // and the statement returns true; else it returns false
        return self.text == filtered
    }
    
    
}
extension UIButton {
   
    func setClearStyledButton() {
        self.backgroundColor = UIColor.clear
        self.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        self.titleLabel?.textColor = UIColor.white
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
    }
    
    
    func setRoundedCornerStyled () {
      
//        self.titleLabel?.font = UIFont.systemFont(ofSize: 2)
        self.titleLabel?.textColor = UIColor.gray
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 2
    }
    
}
extension UIView{
   
    
    func applyShadows() {
        
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 6
        self.layer.shadowColor = UIColor.black.cgColor
    }
    
    
    func origin (point : CGPoint){
        frame.origin.x = point.x
        frame.origin.y = point.y
    }
    
    func copyView() -> UIView {
        
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self))! as! UIView
    }
    
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion:@escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    func addBlurEffect(style: UIBlurEffectStyle) {
        
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
    func removeVisualEffects() {
        
        self.subviews.forEach { (view) in
            if (view is UIVisualEffectView) {
                
                view.removeFromSuperview()
            }
        }
    }
}

var kIndexPathPointer = "kIndexPathPointer"

extension UICollectionView{
    //    var currentIndexPath : NSIndexPath{
    //    get{
    //        return objc_getAssociatedObject(self,kIndexPathPointer) as NSIndexPath
    //    }set{
    //        objc_setAssociatedObject(self, kIndexPathPointer, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
    //    }} WTF! error when building, it's a bug
    //    http://stackoverflow.com/questions/24021291/import-extension-file-in-swift
    
    func setToIndexPath (indexPath : NSIndexPath){
        objc_setAssociatedObject(self, &kIndexPathPointer, indexPath, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func toIndexPath () -> NSIndexPath {
        let index = self.contentOffset.x/self.frame.size.width
        if index > 0{
            return NSIndexPath(row: Int(index), section: 0)
        }else if let indexPath = objc_getAssociatedObject(self,&kIndexPathPointer) as? NSIndexPath {
            return indexPath
        }else{
            return NSIndexPath(row: 0, section: 0)
        }
    }
    
    func fromPageIndexPath () -> NSIndexPath{
        let index : Int = Int(self.contentOffset.x/self.frame.size.width)
        return NSIndexPath(row: index, section: 0)
    }
}
