//
//  Row+CoreDataProperties.swift
//  
//
//  Created by Sarah Cleland on 3/11/16.
//
//

import Foundation
import CoreData


extension Row {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Row> {
        return NSFetchRequest<Row>(entityName: "Row");
    }

    @NSManaged public var estimatedNumberOfCrops: Int16
    @NSManaged public var id: String?
    @NSManaged public var length: Float
    @NSManaged public var name: String?
    @NSManaged public var crops: NSSet?
    @NSManaged public var lifeCycleState: NSSet?
    @NSManaged public var paddock: Paddock?

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

// MARK: Generated accessors for lifeCycleState
extension Row {

    @objc(addLifeCycleStateObject:)
    @NSManaged public func addToLifeCycleState(_ value: RowLifeState)

    @objc(removeLifeCycleStateObject:)
    @NSManaged public func removeFromLifeCycleState(_ value: RowLifeState)

    @objc(addLifeCycleState:)
    @NSManaged public func addToLifeCycleState(_ values: NSSet)

    @objc(removeLifeCycleState:)
    @NSManaged public func removeFromLifeCycleState(_ values: NSSet)

}
