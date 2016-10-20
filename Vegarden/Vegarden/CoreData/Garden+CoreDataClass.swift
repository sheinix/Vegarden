//
//  Garden+CoreDataClass.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData

@objc(Garden)

public class Garden: NSManagedObject {

    public func cleanEverything() {
        
        self.paddocks?.forEach({ (paddock) in
            (paddock as! Paddock).reset()
        })
    }
    
}
