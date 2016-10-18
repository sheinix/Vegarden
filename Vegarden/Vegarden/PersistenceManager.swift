//
//  PersistenceManager.swift
//  
//
//  Created by Juan Nuvreni on 10/1/16.
//
//
import MagicalRecord

//Singleton implementation as a lazy global variable, as is the same as dispatch_once:
//Source http://krakendev.io/blog/the-right-way-to-write-a-singleton

private let sharedPersistanceManager = PersistenceManager()

class PersistenceManager {
    
    class var shared: PersistenceManager {
       
        return sharedPersistanceManager
    }
    
    
    public func setupPersistanceStack() -> Void {
        
        print("set the magical record setupcoredatasatack")
        
        MagicalRecord.setupCoreDataStack(withStoreNamed: "Vegarden")
        
        print("done ok")
    }
 
    public func saveContext() {
        
        
        MagicalRecord.save({ (localContext : NSManagedObjectContext!) in
            
            print ("all good")
            
            })
    }
    
    public func getAllCropsFromPlist(name:String!) -> [Crop] {
        
        //TODO : Change for real object
        var crops = [Crop]()
        if let URL = Bundle.main.url(forResource: name, withExtension: "plist") {
            
            if let cropsFromPlist = NSArray(contentsOf: URL) {
                
                for dictionary in cropsFromPlist {
                    let crop = Veggie(dictionary: dictionary as! NSDictionary)
                    crops.append(crop)
                }
            }
        }
        return crops
    }
    
    public func getMyCropsFromDB() -> [Crop] {
        
        //TODO : Implement MagicalRecord fetch for all Crops
        let crops = [Crop]()
        return crops
    }
}
