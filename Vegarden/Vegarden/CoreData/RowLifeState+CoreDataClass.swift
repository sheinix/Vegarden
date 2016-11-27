//
//  RowLifeState+CoreDataClass.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData

//@objc(RowLifeState)

public class RowLifeState: NSManagedObject {
    
    public var isBeenDeleted : Bool {
        
        get {
            return (self.row == nil)
        }
    }

}
