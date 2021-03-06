//
//  Crop+CoreDataProperties.swift
//  
//
//  Created by Sarah Cleland on 3/11/16.
//
//

import Foundation
import CoreData


extension Crop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Crop> {
        return NSFetchRequest<Crop>(entityName: "Crop");
    }

    @NSManaged public var cropSize: String?
    @NSManaged public var cropType: Int16
    @NSManaged public var diseases: String?
    @NSManaged public var family: String?
    @NSManaged public var growingTips: String?
    @NSManaged public var harvestTips: String?
    @NSManaged public var name: String?
    @NSManaged public var owned: Bool
    @NSManaged public var phLevels: String?
    @NSManaged public var picture: String?
    @NSManaged public var plantingCompanions: String?
    @NSManaged public var plantingDirections: String?
    @NSManaged public var plantType: String?
    @NSManaged public var potentialProblems: String?
    @NSManaged public var spacing: Int16
    @NSManaged public var storageAndUse: String?
    @NSManaged public var timeToHarvest: String!
    @NSManaged public var whenToPlant: String?
    @NSManaged public var row: NSSet?
    @NSManaged public var states: NSSet?

}

// MARK: Generated accessors for row
extension Crop {

    @objc(addRowObject:)
    @NSManaged public func addToRow(_ value: Row)

    @objc(removeRowObject:)
    @NSManaged public func removeFromRow(_ value: Row)

    @objc(addRow:)
    @NSManaged public func addToRow(_ values: NSSet)

    @objc(removeRow:)
    @NSManaged public func removeFromRow(_ values: NSSet)

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

}
