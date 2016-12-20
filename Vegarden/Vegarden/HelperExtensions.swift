//
//  HelperExtensions.swift
//  Vegarden
//
//  Created by Sarah Cleland on 19/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {
    
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    static func isFirstLaunch() -> Bool {
        let firstLaunchFlag = "FirstLaunchFlag"
        let isFirstLaunch = UserDefaults.standard.string(forKey: firstLaunchFlag) == nil
        if (isFirstLaunch) {
            UserDefaults.standard.set("false", forKey: firstLaunchFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}

extension Int {
    
    init(_ range: Range<Int> ) {
        
        let delta = range.lowerBound < 0 ? abs(range.lowerBound) : 0
        let min = UInt32(range.lowerBound + delta)
        let max = UInt32(range.upperBound   + delta)
        self.init(Int(min + arc4random_uniform(max - min)) - delta)
    }
    
    var array: [Int] {
            return description.characters.map{Int(String($0)) ?? 0}
        }
    
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

public extension NSObject {
   
    public class var nameOfClass: String {
        
        return NSStringFromClass(self).components(separatedBy: ".").last!

    }
    
    public var nameOfClass: String {
        
        let strToTrim = NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
        
        return strToTrim.components(separatedBy: "_").first!

    }
    
    func propertyNames() -> [String] {
        return Mirror(reflecting: self).children.flatMap { $0.label }
        }

}

extension UIImage {
    
    var decompressedImage: UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(at: CGPoint.zero)
        let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return decompressedImage!
    }
    
}

public extension Sequence where Iterator.Element: Hashable {
    var uniqueElements: [Iterator.Element] {
        return Array(
            Set(self)
        )
    }
}

public extension Sequence where Iterator.Element: Equatable {
    var uniqueElements: [Iterator.Element] {
        return self.reduce([]){
            uniqueElements, element in
            
            uniqueElements.contains(element)
                ? uniqueElements
                : uniqueElements + [element]
        }
    }
}

extension UITableView {
    
    func indexPathsForRowsIn(section: Int) -> [IndexPath] {
        
        return (0..<self.numberOfRows(inSection: section)).map { IndexPath(row: $0, section: section) }
    }
}

extension UIViewController {
    
    public func showSimpleAlertViewWith(title: String!, message: String!, style: UIAlertControllerStyle) {
        
        let alert = UIAlertController(title: title,
                                    message: message,
                             preferredStyle:style)
            
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { (action:UIAlertAction!) in
                                            
            }
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion:nil)
            
            
        }
    
    public func showAlertView(title: String!, message: String!, style: UIAlertControllerStyle,
                              confirmBlock: @escaping () -> Void, cancelBlock:@escaping () -> Void) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle:style)
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { (action:UIAlertAction!) in
                                        
                     confirmBlock()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
                                     style: .default) { (action:UIAlertAction!) in
                                        
            cancelBlock()
                                        
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion:nil)
        
        
    }

}
extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
    
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    static func color(_ red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
        
        return UIColor(
            colorLiteralRed: Float(1.0) / Float(255.0) * Float(red),
            green: Float(1.0) / Float(255.0) * Float(green),
            blue: Float(1.0) / Float(255.0) * Float(blue),
            alpha: alpha)
    }
}
extension String {
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return ceil(boundingBox.height) + 10
    }
}
