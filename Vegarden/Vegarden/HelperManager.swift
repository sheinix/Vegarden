//
//  HelperManager.swift
//  Vegarden
//
//  Created by Sarah Cleland on 16/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation


public class HelperManager {
    
    public class func getCropDetailCollectionViewFlowLayoutIn (navigationController navController:UINavigationController) -> UICollectionViewFlowLayout {
        
        let flowLayout = UICollectionViewFlowLayout()
        let itemSize  = navController.isNavigationBarHidden ?
            CGSize(width:screenWidth, height:screenHeight+20) : CGSize(width:screenWidth, height:screenHeight-navigationHeaderAndStatusbarHeight)
        
        flowLayout.itemSize = itemSize
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        return flowLayout
    }
    
//    public class func stringAction (action: GrowingActions) -> String! {
//        
//        let strAction : String
//        switch action {
//        case GrowingActions.FertilizeAction:
//            strAction = "Fertilize"
//        case GrowingActions.WaterAction:
//            strAction = "Water"
//        case GrowingActions.WeedAction:
//            strAction = "Weed"
//        case GrowingActions.HarvestAction:
//            strAction = "Harvest"
//        }
//        
//        return strAction
//        
//    }

//    public static func daysBetween(start: Date, end: Date) -> Int {
//        
//        return Calendar.current.dateComponents([.day], from: start, to: end).day!
//    }
    
//    public func daysBetweenDates(startDate: NSDate, endDate: NSDate) -> Int {
//        
//
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.day], from: startDate, to: endDate, options: [])
//        return components.day!
//    
//    }

//TODO Fix it
//    public class func random(digits:Int) -> Int {
//        
//        let min = Int(pow(Double(10), Double(digits-1))) - 1
//        let max = Int(pow(Double(10), Double(digits))) - 1
//        
//        return Int(min...max)
//    }
}

