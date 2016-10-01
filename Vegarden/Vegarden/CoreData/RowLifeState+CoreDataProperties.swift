//
//  RowLifeState+CoreDataProperties.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData


extension RowLifeState {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RowLifeState> {
        return NSFetchRequest<RowLifeState>(entityName: "RowLifeState");
    }

    @NSManaged public var when: NSDate?
    @NSManaged public var isDone: Bool

}
