//
//  Colors.swift
//  Vegarden
//
//  Created by Sarah Cleland on 6/01/17.
//  Copyright © 2017 Juan Nuvreni. All rights reserved.
//

import Foundation

struct Colors {
    
    static let mainColor = UIColor(red: 121/255, green: 178/255, blue: 159/255, alpha: 0.9).cgColor
    static let mainColorUI = UIColor(cgColor: mainColor)
    static let greetingsHeaderColor =  UIColor(red: 57/255, green: 145/255, blue: 233/255, alpha: 0.9)
    
    
    static let mainColorHex : UInt  = 0x79b29f
    
    static let plantColorHex : UInt     = 0x9CD085
    static let plantColor : UIColor = UIColor(netHex: Int(plantColorHex))
    
    static let waterColorHex : UInt     = 0x85BAC5
    static let waterColor : UIColor = UIColor(netHex: Int(waterColorHex))
    
    static let weedColorHex  : UInt     = 0x416531
    static let weedColor : UIColor = UIColor(netHex: Int(weedColorHex))
    
    static let fertilizeColorHex : UInt = 0xDB9B58
    static let fertilizeColor : UIColor = UIColor(netHex: Int(fertilizeColorHex))
    
    static let removeColorHex : UInt    = 0xE16565
    static let removeColor : UIColor = UIColor(netHex: Int(removeColorHex))
    
    static let harvestColorHex : UInt   = 0xD971D9
    static let harvestColor : UIColor = UIColor(netHex: Int(harvestColorHex))
    
    static let finishHarvestColorHex : UInt = 0x27639A
    static let finishHarvestColor : UIColor = UIColor(netHex: Int(finishHarvestColorHex))
    
    
    static let notesColor = UIColor(red: 243/255, green: 235/255, blue: 122/255, alpha: 0.9)
    
    
    static let headerGradient = [mainColor,
                                 // UIColor(red:34/255, green:181/255, blue:235/255, alpha:0.5).cgColor,
        UIColor(red:41/255, green:243/255, blue: 185/255, alpha:0.3).cgColor]
    // UIColor(red:88/255, green:199/255, blue: 140/255, alpha:0.1).cgColor,
    
    //                                 UIColor(red:50.0/255, green:50.0/255, blue:50.0/255, alpha:0.1).CGColor]
}
