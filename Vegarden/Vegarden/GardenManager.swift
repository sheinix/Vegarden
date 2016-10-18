//
//  GardenManager.swift
//  Vegarden
//
//  Created by Sarah Cleland on 16/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation

//Singleton implementation as a lazy global variable, as is the same as dispatch_once:
//Source http://krakendev.io/blog/the-right-way-to-write-a-singleton

private let sharedGadenManager = GardenManager()

class GardenManager {
    
    class var shared: GardenManager {
        
        return sharedGadenManager
    }

    
    public func allCrops() -> [CropVeggie] {
     
        return PersistenceManager.shared.getAllCropsFromPlist(name: "allCrops")
        
    }
    
    public func myOwnedCrops() -> [CropVeggie] {
        
        return PersistenceManager.shared.getMyCropsFromDB()
    }
    
    public func addNewCropToGarden(crop: CropVeggie) {
        
        
    }
    
//    public func getObjectsFromPlist(named name:String!) -> [CropVeggie] {
//        
//        var photos = [CropVeggie]()
//        if let URL = Bundle.main.url(forResource: name, withExtension: "plist") {
//            
//            if let photosFromPlist = NSArray(contentsOf: URL) {
//                
//                for dictionary in photosFromPlist {
//                    let photo = CropVeggie(dictionary: dictionary as! NSDictionary)
//                    photos.append(photo)
//                }
//            }
//        }
//        return photos
//    }
}
