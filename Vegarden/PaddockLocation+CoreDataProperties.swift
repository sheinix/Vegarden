//
//  PaddockLocation+CoreDataProperties.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData


extension PaddockLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PaddockLocation> {
        return NSFetchRequest<PaddockLocation>(entityName: "PaddockLocation");
    }


}
