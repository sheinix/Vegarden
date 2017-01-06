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
    
    func setRoundedCornerStyledWith(borderColor: CGColor, textColor: UIColor) {
        
        self.backgroundColor = UIColor.clear
        self.setTitleColor(textColor, for: .normal)
        self.layer.cornerRadius = UINumbericConstants.commonCornerRadius
        self.layer.borderColor = borderColor
        self.layer.borderWidth = 1
        
    }
    func setRoundedCornerStyled () {
      
//        self.titleLabel?.font = UIFont.systemFont(ofSize: 2)
        self.titleLabel?.textColor = UIColor.gray
        self.layer.cornerRadius = UINumbericConstants.commonCornerRadius
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 2
    }
    
}
extension UIView{
   
    public var hasSuperview : Bool {
        get {
            return (self.superview != nil)
        }
    }
    
    
    //Put everyhing in a Protocol and extend it for every item, this repetead code make me sick! :\
    func applyShadows() {
        
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 6
        self.layer.shadowColor = UIColor.black.cgColor
    }
    
    func applyLightShadow() {
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 6
        self.layer.shadowColor = UIColor.lightGray.cgColor
    }
    
    func applyShadowsForWalkthrough() {
        
        self.layer.shadowOffset = CGSize(width: 2, height: -2)
        self.layer.shadowOpacity = 2
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.darkGray.cgColor
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
    
    public func showConfirmViewWith(title: String!, frame: CGRect? = screenBounds, afterAction: (() -> Void)?) {
        
        
        let confirm = ConfirmationView(frame: frame!, title: title)
        
        self.clipsToBounds = false
//        confirm.clipsToBounds = false
        
        self.addSubview(confirm)
        
        confirm.checkBox?.setCheckState(.checked, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ) {
            
            if afterAction != nil  {
                afterAction!()
            }
           confirm.removeFromSuperview()
        }
        
        self.clipsToBounds = true
    }
    
    func layerGradientWith(colors: [CGColor]) {
        
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame = self.frame
        //layer.frame.origin = CGPoint.zero
        //layer.cornerRadius = CGFloat(frame.width / 20)
        
        
        layer.colors = colors
        
       // layer.colors = [color0,color1,color2,color3,color4,color5,color6]
        self.layer.insertSublayer(layer, at: 0)
//        self.layer.addSublayer(layer)
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
