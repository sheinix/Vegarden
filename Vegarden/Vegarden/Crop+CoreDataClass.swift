//
//  Crop+CoreDataClass.swift
//  Vegarden
//
//  Created by Sarah Cleland on 18/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData


//@objc(Crop)

public class Crop: NSManagedObject {
        
    var typeCrop : CropTypes {
        
        get {
            return CropTypes(rawValue: Int16(self.cropType.intValue))!
        }
        set {
            self.cropType = NSNumber(value:Int16(newValue.rawValue))
        }
    }
    
    
    //Will be the computed time depending on how you plant the crop, if is seedling or seed. self.timeToHarvest will be a double with the Int part matchiing the seed time and the decimal part matching the seedling
    var computedTimeToHarvest: Int {
       
        get {
            
            let value = String(self.timeToHarvest.intValue).components(separatedBy: ".")
            
            return (self.timeToHarvest.intValue % 1) == 0 ? Int(value.first!)! : Int(value.last!)!
            
            }
    }
    
    
    public class func getCropFrom(dictionary: NSDictionary) -> Crop {
        
        //TODO need to know which type of crop is before creating
        
        let crop = Veggie.mr_createEntity()! as Crop
        
        crop.name        =   dictionary["name"] as? String
        crop.picture     =   dictionary["picture"] as? String
        crop.family      =   dictionary["plantFamily"] as? String
        
        crop.owned       =   false
        
        crop.cropType    =   0// dictionary["plantType"] as? String
        crop.cropSize    =   NSNumber(value: (Int(dictionary["plantSize"] as! Int)))
        crop.phLevels    =   NSNumber(value: (Int(dictionary["phLevels"] as! Int)))
        crop.spacing     =   NSNumber(value: (Int(dictionary["spacing"] as! Int)))
        crop.timeToHarvest = NSNumber(value: 30)
        
        crop.whenToPlant        = dictionary["whenToPlant"] as? String
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
