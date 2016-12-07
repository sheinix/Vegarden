//
//  Paddock+CoreDataProperties.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData 

extension Paddock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Paddock> {
        return NSFetchRequest<Paddock>(entityName: "Paddock");
    }

    @NSManaged public var name: String?
    @NSManaged public var paddockId: String?
    @NSManaged public var garden: Garden?
    @NSManaged public var rows: NSSet?
    @NSManaged public var location: Location?
    @NSManaged public var soil: Soil?
 
    public var rowsNamePrefix: String? {
        
        set {
            self.willChangeValue(forKey: "rowsNamePrefix")
            self.setPrimitiveValue(newValue, forKey: "rowsNamePrefix")
            self.didChangeValue(forKey: "rowsNamePrefix")

            if let rows = self.rows?.allObjects {
                
                _ = rows.map { ($0 as! Row).name = rowsNamePrefix!+String(arc4random()) }
            }

        }
        
        get {
            self.willAccessValue(forKey: "rowsNamePrefix")
            let text = self.primitiveValue(forKey: "rowsNamePrefix") as? String
            self.didAccessValue(forKey: "rowsNamePrefix")
            return text
        }
    }
}

// MARK: Generated accessors for rows
extension Paddock {

    @objc(addRowsObject:)
    @NSManaged public func addToRows(_ value: Row)

    @objc(removeRowsObject:)
    @NSManaged public func removeFromRows(_ value: Row)

    @objc(addRows:)
    @NSManaged public func addToRows(_ values: NSSet)

    @objc(removeRows:)
    @NSManaged public func removeFromRows(_ values: NSSet)

}
