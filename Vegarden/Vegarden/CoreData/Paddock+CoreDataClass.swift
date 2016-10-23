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

    public func reset() {
        
        self.rows?.forEach({ (element) in
            (element as! Row).reset()
        })
    }
    
}
