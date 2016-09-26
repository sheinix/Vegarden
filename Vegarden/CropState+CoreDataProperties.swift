//
//  CropState+CoreDataProperties.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData


extension CropState {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CropState> {
        return NSFetchRequest<CropState>(entityName: "CropState");
    }

    @NSManaged public var time: NSDate?

}
