//
//  Crop+CoreDataProperties.swift
//  Vegarden
//
//  Created by Sarah Cleland on 18/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData

extension Crop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Crop> {
        return NSFetchRequest<Crop>(entityName: "Crop");
    }
    
    @NSManaged public var name: String!
    @NSManaged public var cropType: NSNumber
    @NSManaged public var picture: String?
    @NSManaged public var family: String?
    @NSManaged public var cropSize: NSNumber
    @NSManaged public var phLevels: NSNumber
    @NSManaged public var spacing: NSNumber
    @NSManaged public var timeToHarvest: NSNumber
    @NSManaged public var whenToPlant: String?
    @NSManaged public var row: NSSet?
    @NSManaged public var states: NSSet?
    @NSManaged public var owned: Bool
    @NSManaged public var plantingDirections: String?
    @NSManaged public var plantType: String?
    @NSManaged public var growingTips: String?
    @NSManaged public var diseases: String?
    @NSManaged public var potentialProblems: String?
    @NSManaged public var harvestTips: String?
    @NSManaged public var storageAndUse: String?
    @NSManaged public var plantingCompanions: String?
}

// MARK: Generated accessors for states
extension Crop {

    @objc(addStatesObject:)
    @NSManaged public func addToStates(_ value: CropState)

    @objc(removeStatesObject:)
    @NSManaged public func removeFromStates(_ value: CropState)

    @objc(addStates:)
    @NSManaged public func addToStates(_ values: NSSet)

    @objc(removeStates:)
    @NSManaged public func removeFromStates(_ values: NSSet)
    
    ////
    @objc(addRowObject:)
    @NSManaged public func addToRow(_ value: Row)
    
    @objc(removeRowObject:)
    @NSManaged public func removeFromRow(_ value: Row)
    
    @objc(addRow:)
    @NSManaged public func addToRow(_ values: NSSet)
    
    @objc(removeRow:)
    @NSManaged public func removeFromRow(_ values: NSSet)

}
