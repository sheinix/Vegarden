//
//  HelperExtensions.swift
//  Vegarden
//
//  Created by Sarah Cleland on 19/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation

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
}

extension Date {
   
    public static func daysBetween(start: Date, end: Date) -> Int {
        
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    

    public static func addNumberOf(days:Int, to date: Date) -> Date! {
        
        var cal = Calendar.current
        cal.timeZone = TimeZone(abbreviation: "UTC")!
        
        var comps = DateComponents()
        comps.day = days
        
        return cal.date(byAdding: comps, to: date)
    }
    
}
