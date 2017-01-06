
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
    
    var isReadyForHarvest : Bool {
        
        get {
            
            return (estimatedDaysLeftToHarvest <= 0)
        }
    }
    
    public var hasBeenHarvested : Bool {
        
        get {
            return getHarvestingStates() != nil
        }
    }
    
    public var isFromSeed : Bool {
        
        get {
            return ((getStatesOf(type: .Seed)!.count > 0) ? true : false )
        }

    }
    
//MARK: - Time Management Methods:
    
    public var percentageCompleted : Double {
        get {
            
            let percentage = Double(Double(daysPassedSincePlanted) / Double(computedTimeToHarvest)).roundTo(places: 2)
            
            return (percentage <= 0.00 ? 0.01 : (percentage > 1 ? 1.00 : percentage))
        }
    }
    
    
    public var estimatedWeeksLeftToHarvest : Int {
        
        get {
            
            return Date.weeksBetween(start: Date(), end: estimatedHarvestDate)
        }
    }
    
 
    public var estimatedMonthsLeftToHarvest : Int {
        
        get {
            
            return Date.monthsBetween(start: Date(), end: estimatedHarvestDate)
        }
        
    }
    
    public var estimatedDaysLeftToHarvest : Int {
        
        get {
            return Date.daysBetween(start: Date(), end: estimatedHarvestDate)
        }
    }
    
    public var estimatedHarvestDate : Date {
        
        get {
            guard let dayPlanted = dayPlanted else { return Date() }
            
            return Date.addNumberOf(days: self.computedTimeToHarvest, to: dayPlanted)
        }
        
    }
    
    public var daysPassedSincePlanted : Int {
        
        get {
            guard let dayPlanted = dayPlanted else { return -1 }
            
            return Date.daysBetween(start:dayPlanted, end: Date())
        }
    }
    
    public var dayPlanted : Date? {
        
        get {
            if let firstState = self.getPlantedtCropState() {
                
                guard ((firstState is Seedling || firstState is Seed) && (firstState.date != nil)) else {
                    
                    return nil
                }
                
                return (firstState.date as Date)
            }
            
            return nil
        }
    }
    
//MARK: - Helper Methods:
    
    private func getPlantedtCropState() -> CropState? {
        
        let state =  self.states?.allObjects.filter( { ($0 as! CropState) is Seed || ($0 as! CropState) is Seedling } )
        
        guard let states = state, (state?.count)! > 0 else { return nil }
        
        return (states[0] as! CropState)
        
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
                classState = Harvesting.self
            default:
                break
        }
        
        return classState
    }


    public func getHarvestingStates() -> [Harvesting]? {
        
        guard let returnStates : [Harvesting] = self.states?.filter( { ($0 as! CropState) is Harvesting }) as! [Harvesting]? else { return nil }
        
        
        return (returnStates.count > 0 ?  returnStates.sorted(by: { (harv1, harv2) -> Bool in
            return harv1.date > harv2.date
        }) : nil )
    }
    
    private func getOrderedStates() -> [CropState]? {
        
        let orderedStates = self.states?.allObjects.sorted(by: { (state1, state2) -> Bool in
            
            let date1 = (state1 as! CropState).date
            let date2 = (state2 as! CropState).date
            
            return date1! > date2!
            
        })
        
        return ((orderedStates?.count)! > 0 ? (orderedStates as! [CropState]) : nil)
        
    }
    
    public var cropTypeStringValue : String {
      
        get {
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
    }
    
    public var actionsMade : [RowLifeState] {
        
        get {
            
            var states : [RowLifeState] = []
            
            self.row?.forEach({ (row) in
                
                (row as! Row).lifeCycleState?.forEach({ (rowState) in
                    
                   if !(states.contains(where:{ (staty) -> Bool in
                    
                    return (staty.lifeStateId == (rowState as! RowLifeState).lifeStateId) })) {
                    
                        states.append(rowState as! RowLifeState)
                    }
                })
            })
            
            return states.sorted(by: { (rowState1, rowState2) -> Bool in
                return rowState1.when! > rowState2.when!
            })
        }
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
