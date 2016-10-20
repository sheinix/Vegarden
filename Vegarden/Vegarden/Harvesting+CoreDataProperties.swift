//
//  Harvesting+CoreDataProperties.swift
//  
//
//  Created by Sarah Cleland on 20/10/16.
//
//

import Foundation
import CoreData


extension Harvesting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Harvesting> {
        return NSFetchRequest<Harvesting>(entityName: "Harvesting");
    }


}
