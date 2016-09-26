//
//  Irrigated+CoreDataProperties.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData


extension Irrigated {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Irrigated> {
        return NSFetchRequest<Irrigated>(entityName: "Irrigated");
    }


}
