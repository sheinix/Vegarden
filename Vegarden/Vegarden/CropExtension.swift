//
//  CropExtension.swift
//  Vegarden
//
//  Created by Sarah Cleland on 21/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation


extension Crop {
    

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
        
        let orderedStates = self.states?.allObjects.sorted(by: { (date1, date2) -> Bool in
            
            return (date1 as! Date) > (date2 as! Date)
            
        })
        
        return (orderedStates?[0] as! CropState)
        
    }


}
