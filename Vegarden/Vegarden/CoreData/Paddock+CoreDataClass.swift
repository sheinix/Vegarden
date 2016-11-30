//
//  Paddock+CoreDataClass.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData

//@objc(Paddock)

public class Paddock: NSManagedObject {
    
    public var plantedRows : [Row] {
        
        get {
            
            return self.rows?.allObjects.filter { ($0 as! Row).isPlanted } as! [Row]
        }
    }
    
    public var freeRows : [Row] {
       
        get {
            
            return self.rows?.allObjects.filter { !($0 as! Row).isPlanted } as! [Row]
        }
    }
    
    
    public func reset() {
        
        self.rows?.forEach({ (element) in
            (element as! Row).reset()
        })
    }
    
    public func getPlantedRowsFor(crop: Crop) -> [Row] {
        
        return plantedRows.filter { ($0.crops?.allObjects[0] as! Crop) == crop }
        
    }
    
}
