//
//  CropState+CoreDataProperties.swift
//  
//
//  Created by Sarah Cleland on 18/10/16.
//
//

import Foundation
import CoreData


extension CropState {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CropState> {
        return NSFetchRequest<CropState>(entityName: "CropState");
    }

    @NSManaged public var date: NSDate!

}
