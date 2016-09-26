//
//  GardenLocation+CoreDataProperties.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData


extension GardenLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GardenLocation> {
        return NSFetchRequest<GardenLocation>(entityName: "GardenLocation");
    }

    @NSManaged public var altitude: Double
    @NSManaged public var longitude: Double

}
