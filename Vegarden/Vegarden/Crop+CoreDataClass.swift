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
            return CropTypes(rawValue: self.cropType)!
        }
        set {
            self.cropType = Int16(NSNumber(value:Int16(newValue.rawValue)))
        }
    }
    
    var isPlanted : Bool {
        
        get {
            guard (self.row?.count) != nil else { return false }
            
            return ((self.row?.count)! > 0)
        }
    }

    
    //Computed time depending on how you plant the crop:
    // if is Seedling or Seed. TimeToHarvest is a String with two components separated by "."
    // First component is time for Seed and last for Seedling
    
    var computedTimeToHarvest: Int {
       
        get {
            
            let value = self.timeToHarvest.components(separatedBy: ".")
            
            return self.isFromSeed ? Int(value.first!)! : Int(value.last!)!
            
//            return (self.timeToHarvest % 1) == 0 ? Int(value.first!)! : Int(value.last!)!
            
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
        crop.cropSize    =   dictionary["plantSize"] as? String
        crop.phLevels    =   dictionary["phLevels"] as? String
        crop.spacing     =   Int16(Int(dictionary["spacing"] as! Int))
        crop.timeToHarvest =  "30.45"
        
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
