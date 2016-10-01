//
//  UIColorEx.swift
//  LiquidLoading
//
//  Created by Takuma Yoshida on 2015/08/21.
//  Copyright (c) 2015年 yoavlt. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    var red1: CGFloat {
        get {
            let components = self.cgColor.components
            return components![0]
        }
    }
    
    var green: CGFloat {
        get {
            let components = self.cgColor.components
            return components![1]
        }
    }
    
    var blue: CGFloat {
        get {
            let components = self.cgColor.components
            return components![2]
        }
    }
    
    var alpha: CGFloat {
        get {
            return self.cgColor.alpha
        }
    }

    func alpha(_ alpha: CGFloat) -> UIColor {
        return UIColor(red: self.red1, green: self.green, blue: self.blue, alpha: alpha)
    }
    
    func white(_ scale: CGFloat) -> UIColor {
        return UIColor(
            red: self.red1 + (1.0 - self.red1) * scale,
            green: self.green + (1.0 - self.green) * scale,
            blue: self.blue + (1.0 - self.blue) * scale,
            alpha: 1.0
        )
    }
}
