
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
        
        guard let daysToHarvest = getEstimatedDaysLeftToHarvest() else { return false }
        
        return (daysToHarvest == 0)
        
    }
    
    public func hasBeenHarvested() -> Bool {
        
        return getHarvestingStates() != nil
        
    }
    
    public func isFromSeed() -> Bool {
        
        return ((getStatesOf(type: .Seed) != nil) ? true : false )
        
    }
    
//MARK: - Time Management Methods:
    
    public func getEstimatedWeeksLeftToHarvest() -> Int? {
        
        guard let harvestDate = getEstimatedHarvestDate() else { return nil }
        
        return Date.weeksBetween(start: Date(), end: harvestDate)
    }
    
 
    public func getEstimatedMonthsLeftToHarvest() -> Int? {
        
        guard let harvestDate = getEstimatedHarvestDate() else { return nil }
        
        return Date.monthsBetween(start: Date(), end: harvestDate)
    }
    
    public func getEstimatedDaysLeftToHarvest() -> Int? {
        
        guard let harvestDay = getEstimatedHarvestDate() else { return nil }
        
        return Date.daysBetween(start: Date(), end: harvestDay)
    }
    
    public func getEstimatedHarvestDate() -> Date? {
        
        guard let dayPlanted = getDayPlanted() else { return nil }
        
        return Date.addNumberOf(days: Int(self.timeToHarvest), to: dayPlanted)
    }
    
    public func getDaysPassedSincePlanted() -> Int? {
        
        guard let dayPlanted = getDayPlanted() else { return nil }
        
        return Date.daysBetween(start:dayPlanted, end: Date())
    }
    
    public func getDayPlanted() -> Date? {
        
        if let firstState = self.getPlantedtCropState() {
            
            guard ((firstState is Seedling || firstState is Seed) && (firstState.date != nil)) else {
                
                return nil
            }
            
            return (firstState.date as Date)
        }
        
        return nil
    }
    
//MARK: - Helper Methods:
    
    private func getPlantedtCropState() -> CropState? {
        
        guard let orderedStates = getOrderedStates() else { return nil }
    
        return orderedStates[0]
        
    }
    
    private func getAllStates() -> [CropState] {
        
        return self.states?.allObjects as! [CropState]
    }
    
    
    //TODO Make this method work with the planting states! For now use the different Methods above
    public func getStatesOf(type:plantingStates) -> [CropState]? {

        guard let allStates = self.states?.allObjects else { return nil }
        
        var returnArray = [CropState]()
        
        let growState : CropState.Type = stateForType(type: type)!
        
        for state in allStates as! [CropState] {
            
            if (state .isKind(of:growState)) {
                
                returnArray.append(state)
            }
        }
        
        return returnArray
    }

    public func stateForType(type: plantingStates) -> CropState.Type? {
        
        var classState : CropState.Type? = nil
        
        switch type {
            case .Seed:
                classState = Seed.self
            case .Seedling:
                classState = Seedling.self
            case .Growing:
                classState = Growing.self
            case .Grown:
                classState = Grown.self
            case .Harvested:
                classState = Harvested.self
            default:
                break
        }
        
        return classState
    }


    private func getHarvestingStates() -> [Harvesting]? {
        
        var returnStates : [CropState]? = nil
        
        
        self.states?.allObjects.forEach({ (cropState) in
            
            if (type(of: cropState) == Harvesting.self) {
                
                returnStates?.append(cropState as! CropState)
            }
            
        })
        
        return returnStates as! [Harvesting]?
    }

//    public func getSeedState() -> Seed {
//
//        var seedState : Seed
//        
//        
//        self.states?.allObjects.forEach({ (cropState) in
//            
//            if (type(of: cropState) == Seed.self) {
//                
//                seedState = (cropState as! Seed)
//            }
//            
//        })
//        
//        return seedState
//    }
//    
    
    private func getOrderedStates() -> [CropState]? {
        
        let orderedStates = self.states?.allObjects.sorted(by: { (state1, state2) -> Bool in
            
            let date1 = (state1 as! CropState).date
            let date2 = (state2 as! CropState).date
            
            return (date1 as! Date) > (date2 as! Date)
            
        })
        
        return ((orderedStates?.count)! > 0 ? (orderedStates as! [CropState]) : nil)
        
    }
    
    public func cropTypeStringValue() -> String {
        
        var stringValue : String
        
        switch self.typeCrop {
            
            case .Annual:
        
                stringValue = "Annunal"
        
            case .Perenneal:
        
                stringValue = "Perenneal"
        
            case .Tuba:
        
                stringValue = "Tuba"
        
//            default:
//                stringValue = ""
        }
        
        return stringValue
        
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
