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
    
    public func reset() {
        
        _ = self.crops?.map({($0 as! Crop).mr_deleteEntity()})
        
        _ = self.lifeCycleState?.map({($0 as! Crop).mr_deleteEntity()})
        
    }

    public func getAllRowLifeStates() -> [RowLifeState] {
        
        return self.lifeCycleState?.allObjects as! [RowLifeState]
    }
}
