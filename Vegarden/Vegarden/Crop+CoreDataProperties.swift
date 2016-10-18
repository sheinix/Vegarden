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
    @NSManaged public var cropType: Int16
    @NSManaged public var picture: String?
    @NSManaged public var family: String?
    @NSManaged public var size: Int16
    @NSManaged public var phLevels: Int16
    @NSManaged public var spacing: Int16
    @NSManaged public var whenToPlant: String?
    @NSManaged public var row: Row?
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

}

extension Crop {
    
    convenience init(dictionary: NSDictionary) {
        
        
        let crop = Crop.mr_createEntity()! as Crop
        
        self.init()

        crop.name        =   dictionary["name"] as? String
        crop.picture     =   dictionary["picture"] as? String
        crop.family      =   dictionary["plantFamily"] as? String
        crop.owned       =   false
        crop.cropType    =   0// dictionary["plantType"] as? String
        crop.size        =   (dictionary["siize"] as? Int16)!
        crop.phLevels    =   (dictionary["phLevels"] as? Int16)!
        crop.spacing     =   (dictionary["spacing"] as? Int16)!
        crop.whenToPlant =   dictionary["whenToPlant"] as? String
        crop.plantingDirections = dictionary["plantDirections"] as? String
        crop.plantType          = dictionary["plantType"] as? String
        crop.growingTips        = dictionary["growingTips"] as? String
        crop.diseases           = dictionary["diseases"] as? String
        crop.potentialProblems  = dictionary["potentialProblems"] as? String
        crop.harvestTips        = dictionary["harvestTips"] as? String
        crop.storageAndUse      = dictionary["Storage&dUse"] as? String
        crop.plantingCompanions = dictionary["plantingCompanions"] as? String
        
    }
    
    

}
