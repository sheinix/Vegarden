//
//  Row+CoreDataClass.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData

//@objc(Row)

public class Row: NSManagedObject {
    
    public var isPlanted : Bool {
        
        get {
            return ((self.crops?.count)! > 0)
        }
    }
    
    
//    public func resetFor(crop: Crop) {
//TODO This commented code is in a future case where i can plant more than one crop in a row
//        _ = self.crops?.filter { ($0 as! Crop) === crop }.forEach { ($0 as! Crop).removeFromRow(_:self) }
    
    public func reset() {

        self.lifeCycleState?.forEach { ($0 as! RowLifeState).mr_deleteEntity() }
        
        self.crops?.forEach({ crop in
            
            (crop as! Crop).removeFromRow(_:self)
            self.removeFromCrops((crop as! Crop))
        })

    }

    public func getAllRowLifeStates() -> [RowLifeState] {
        
        return self.lifeCycleState?.allObjects as! [RowLifeState]
    }
}
