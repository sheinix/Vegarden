//
//  CropExtension.swift
//  Vegarden
//
//  Created by Sarah Cleland on 21/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation


extension Crop {
    
//MARK: - Boolean Methods:
    
    public func isReadyForHarvest() -> Bool {
        
        return (getEstimatedDaysLeftToHarvest() == 0)
        
    }
    
    public func hasBeenHarvested() -> Bool {
        
        return getHarvestingStates() != nil
        
    }
    
    
//MARK: - Time Management Methods:
    
    public func getEstimatedWeeksLeftToHarvest() -> Int {
        
        return Date.weeksBetween(start: Date(), end: getEstimatedHarvestDate())
    }
    
 
    public func getEstimatedMonthsLeftToHarvest() -> Int {
        
        return Date.monthsBetween(start: Date(), end: getEstimatedHarvestDate())
    }
    
    public func getEstimatedDaysLeftToHarvest() -> Int {
        
        return Date.daysBetween(start: Date(), end: getEstimatedHarvestDate())
    }
    
    public func getEstimatedHarvestDate() -> Date {
        
        return Date.addNumberOf(days: self.timeToHarvest.intValue, to: getDayPlanted()!)
    }
    
    public func getDaysPassedSincePlanted() -> Int {
        
        return Date.daysBetween(start:getDayPlanted()!, end: Date())
    }
    
    public func getDayPlanted() -> Date? {
        
        let state = self.getPlantedtCropState()
        
        if let firstState = state {
            
            guard ((firstState is Seedling || firstState is Seed) && (firstState.date != nil)) else {
                
                return nil
            }
        }
        
        return (state?.date as! Date)
    }
    
//MARK: - Helper Methods:
    
    private func getPlantedtCropState() -> CropState? {
        
        let orderedStates = getOrderedStates()
        
        return orderedStates[0]
        
    }
    
    private func getAllStates() -> [CropState] {
        
        return self.states?.allObjects as! [CropState]
    }
    
    
    //TODO Make this method work with the planting states! For now use the different Methods above
//    public func getStatesOf(type:plantingStates) -> [CropState] {
//        
//        let returnStates : [CropState]
//
//    }

    private func getHarvestingStates() -> [Harvesting]? {
        
        var returnStates : [CropState]? = nil
        
        
        self.states?.allObjects.forEach({ (cropState) in
            
            if (type(of: cropState) == Harvesting.self) {
                
                returnStates?.append(cropState as! CropState)
            }
            
        })
        
        return returnStates as! [Harvesting]?
    }

    private func getOrderedStates() -> [CropState] {
        
        let orderedStates = self.states?.allObjects.sorted(by: { (date1, date2) -> Bool in
            
            return (date1 as! Date) > (date2 as! Date)
            
        })
        
        return orderedStates as! [CropState]
    }
    
    
//    public func reCalculateTimeToHarvest() {
//        
//        self.timeToHarvest = NSNumber(value:self.computedTimeToHarvest)
//        
//    }
//    
//    public func getSeedlingTimeToHarvest() -> Int {
//       
//        let value = String(self.timeToHarvest.intValue).components(separatedBy: ".")
//        
//        return (self.timeToHarvest.intValue % 1) == 0 ? Int(value.first!)! : Int(value.last!)!
//        
//    }
//    
//    public func getSeedTimeToHarvest() -> Int {
//        
//    }
}
