//
//  Crop+CoreDataClass.swift
//  Vegarden
//
//  Created by Sarah Cleland on 18/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData

@objc(Crop)

public class Crop: NSManagedObject {
    
    var typeCrop : CropTypes {
        
        get {
            return CropTypes(rawValue: self.cropType)!
        }
        set {
            self.cropType = newValue.rawValue
        }
    }
    
    
    public class func getCropFrom(dictionary: NSDictionary) -> Crop {
        
        //TODO need to know which type of crop is before creating
        
        let crop = Veggie.mr_createEntity()! as Crop
        
        crop.name        =   dictionary["name"] as? String
        crop.picture     =   dictionary["picture"] as? String
        crop.family      =   dictionary["plantFamily"] as? String
        crop.owned       =   false
        // crop.cropType    =   0// dictionary["plantType"] as? String
       // crop.cropSize    =   Int32((dictionary["plantSize"] as? NSNumber)!.int32Value)
      //  crop.phLevels    =   Int32((dictionary["phLevels"] as? NSNumber)!.int32Value)
      //  crop.spacing     =   Int32((dictionary["spacing"] as? NSNumber)!.int32Value)
        crop.whenToPlant =   dictionary["whenToPlant"] as? String
        crop.plantingDirections = dictionary["plantDirections"] as? String
        crop.plantType          = dictionary["plantType"] as? String
        crop.growingTips        = dictionary["growingTips"] as? String
        crop.diseases           = dictionary["diseases"] as? String
        crop.potentialProblems  = dictionary["potentialProblems"] as? String
        crop.harvestTips        = dictionary["harvestTips"] as? String
        crop.storageAndUse      = dictionary["Storage&dUse"] as? String
        crop.plantingCompanions = dictionary["plantingCompanions"] as? String
        
        return crop
        
    }


}
