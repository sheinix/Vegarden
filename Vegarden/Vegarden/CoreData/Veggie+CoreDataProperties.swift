//
//  Veggie+CoreDataProperties.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData


extension Veggie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Veggie> {
        return NSFetchRequest<Veggie>(entityName: "Veggie");
    }


}
