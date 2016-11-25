//
//  RowLifeState+CoreDataProperties.swift
//  
//
//  Created by Sarah Cleland on 25/11/16.
//
//

import Foundation
import CoreData


extension RowLifeState {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RowLifeState> {
        return NSFetchRequest<RowLifeState>(entityName: "RowLifeState");
    }

    @NSManaged public var isDone: Bool
    @NSManaged public var notes: String?
    @NSManaged public var when: NSDate?
    @NSManaged public var row: Row?
    @NSManaged public var lifeStateId: String?
}
