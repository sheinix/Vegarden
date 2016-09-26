//
//  Crop+CoreDataProperties.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData 

extension Crop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Crop> {
        return NSFetchRequest<Crop>(entityName: "Crop");
    }

    @NSManaged public var name: String?
    @NSManaged public var cropType: NSObject?
    @NSManaged public var state: CropState?

}
