//
//  DateExtension.swift
//  Vegarden
//
//  Created by Sarah Cleland on 21/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation

extension Date {
    
    public static func daysBetween(start: Date, end: Date) -> Int {
        
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    public static func weeksBetween(start: Date, end:Date) -> Int {
       
        return Calendar.current.dateComponents([.weekOfYear], from: start, to: end).weekOfYear ?? 0
    }
    
    public static func monthsBetween(start: Date, end:Date) -> Int {
        
        return Calendar.current.dateComponents([.month], from: start, to: end).month ?? 0
    }
    
    public static func addNumberOf(days:Int, to date: Date) -> Date! {
        
        var cal = Calendar.current
        cal.timeZone = TimeZone(abbreviation: "UTC")!
        
        var comps = DateComponents()
        comps.day = days
        
        return cal.date(byAdding: comps, to: date)
    }
    
//MARK: - Time Passed Since Date() Methods:
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
    public func inCellDateFormat() -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMMM dd yyyy"
    
        let convertedDateString = dateFormatter.string(from: self)
        
        return convertedDateString
    }
   
    public func inShortFormat() -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        let convertedDateString = dateFormatter.string(from: self)
        
        return convertedDateString
    }
    public func currentTime() -> String {
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minutes = calendar.component(.minute, from: self)
        let minutesStr = (minutes.array.count == 1 ? "0" + String(minutes) : String(minutes))
        
        return (String(hour) + " : " + minutesStr)
        
    }
    
    public static func greetings() -> String! {
        
        var msg : String = "Good "
        
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
            case 6..<12  : msg = msg + "Morning"
            case 12..<17 : msg = msg + "Afternoon"
            case 17..<22 : msg = msg + "Evening"
            
            default: msg = msg + "Night"
        }
        
        return msg
    }
    
    public func isGreaterThanDate(dateToCompare: Date) -> Bool {
    
        return self.compare(dateToCompare) == ComparisonResult.orderedDescending
    }
    
    public func isLessThanDate(dateToCompare: Date) -> Bool {
    
        return self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending
    }
    
    public func isEqualToDate(dateToCompare: Date) -> Bool {
  
        return self.compare(dateToCompare) == ComparisonResult.orderedSame
    }
    
    public var strMinSecId : String {
        
        get {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.sssx"
            return formatter.string(from: self)

        }
    }
}
