//
//  Garden+CoreDataProperties.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData 

extension Garden {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Garden> {
        return NSFetchRequest<Garden>(entityName: "Garden");
    }

    @NSManaged public var name: String?
    @NSManaged public var paddocks: NSSet?
    @NSManaged public var location: Location?

}

// MARK: Generated accessors for paddocks
extension Garden {

    @objc(addPaddocksObject:)
    @NSManaged public func addToPaddocks(_ value: Paddock)

    @objc(removePaddocksObject:)
    @NSManaged public func removeFromPaddocks(_ value: Paddock)

    @objc(addPaddocks:)
    @NSManaged public func addToPaddocks(_ values: NSSet)

    @objc(removePaddocks:)
    @NSManaged public func removeFromPaddocks(_ values: NSSet)

}
