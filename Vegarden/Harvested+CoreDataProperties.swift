//
//  Harvested+CoreDataProperties.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData


extension Harvested {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Harvested> {
        return NSFetchRequest<Harvested>(entityName: "Harvested");
    }


}
