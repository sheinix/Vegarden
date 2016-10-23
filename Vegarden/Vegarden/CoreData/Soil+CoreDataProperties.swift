//
//  Soil+CoreDataProperties.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData


extension Soil {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Soil> {
        return NSFetchRequest<Soil>(entityName: "Soil");
    }

    @NSManaged public var phLevel: Int16
}
