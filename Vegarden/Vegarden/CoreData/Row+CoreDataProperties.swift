//
//  Row+CoreDataProperties.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData 

extension Row {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Row> {
        return NSFetchRequest<Row>(entityName: "Row");
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var crops: NSSet?
    @NSManaged public var lifeCycleState: RowLifeState?

}

// MARK: Generated accessors for crops
extension Row {

    @objc(addCropsObject:)
    @NSManaged public func addToCrops(_ value: Crop)

    @objc(removeCropsObject:)
    @NSManaged public func removeFromCrops(_ value: Crop)

    @objc(addCrops:)
    @NSManaged public func addToCrops(_ values: NSSet)

    @objc(removeCrops:)
    @NSManaged public func removeFromCrops(_ values: NSSet)

}
