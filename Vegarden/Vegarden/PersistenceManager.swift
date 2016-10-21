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
    
// MARK: - CoreData/MagicalRecord Methods
    
    public func getContext() -> NSManagedObjectContext {
        
        return NSManagedObjectContext.mr_default()
    }
    
    
    public func setupPersistanceStack() -> Void {
        
        print("set the magical record setupcoredatasatack")
        
        MagicalRecord.setupCoreDataStack(withStoreNamed: "Vegarden")
        
        if (UserDefaults.isFirstLaunch()) {
            populateDB()
            saveContext()
        }
        
        generateASampleGarden()
        
        print("done ok")
    }
 
    public func saveContext() {
        
        //TODO Try to see how to save on background, because now is blocking the main thread for saving
        
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        

        print ("all good")
            

    }

//    
//    public func createGardenNamed(name: String!) -> Garden {
//        
//        let garden = Garden.mr_createEntity()
//        garden?.name = name
//        garden?.paddocks = nil
//        garden?.location = nil
//        
//        saveContext()
//        
//        return garden!
//    }

//MARK: - Garden Management Methods
    
    public func createGardenNamed(name: String!, in location:Location?, withPaddocks paddock: [Paddock]?) -> Garden {
        
        let garden = Garden.mr_createEntity()
        
        garden?.name = name
        garden?.paddocks = NSSet(array: paddock!)
        garden?.location = location
        
        saveContext()
        
        return garden!
    }
    
    
    public func remove(garden: Garden) {
        
        garden.mr_deleteEntity()
        
    }
    
    public func getAllGardens() -> [Garden] {
        
        return Garden.mr_findAll() as! [Garden]
    }
    
// MARK: - Paddock Management Methods
    
    
    public func addPaddocks(paddocks:[Paddock], to garden: Garden) {
        
        garden.addToPaddocks(NSSet(array: paddocks))
    }
    
    public func addPaddock(paddock: Paddock, to garden: Garden) {
        
        garden.addToPaddocks(paddock)
    }
    
    public func removePaddocks(paddocks:[Paddock], from garden: Garden) {
        
        paddocks.forEach({ $0.mr_deleteEntity() })
    }
    
    public func removePaddock(paddock: Paddock, from garden: Garden) {
        
        paddock.mr_deleteEntity()
    }
    
    public func getAllPaddocks() -> [Paddock] {
        
        return Paddock.mr_findAll() as! [Paddock]
    }
    
// MARK: - Row Management Methods
    
    public func addRow(rowName: String!, length: Float?, to paddock: Paddock, in garden: Garden) {
        
        let newRow = Row.mr_createEntity()
        newRow?.name = rowName
        newRow?.id = UUID().uuidString
        newRow?.length = (length == nil ? nil : NSNumber(value: length!))
        paddock.addToRows(newRow!)
        
    }
    
    public func addRows(numberOfRows: Int, to paddock: Paddock, in garden: Garden) {
        
        var rowName : String
        
        for _ in (0..<numberOfRows) {
 //TODO Check helper method to see how can i get the randoms with a fixed length
//            rowName = "V_"+String(HelperManager.random(digits: 5))
             rowName = "V_"+String(arc4random())
            
            
            addRow(rowName: rowName, length: nil, to: paddock, in: garden)
            
        }
    }
    
    public func removeRow(row: Row, from paddock: Paddock, in garden: Garden) {
        
        row.mr_deleteEntity()
        
    }
    
    public func removeRows(rows: [Row], from paddock: Paddock, in garden: Garden) {
        
        rows.forEach({ $0.mr_deleteEntity() })
    }

    public func getAllRows() -> [Row] {
        
        return Row.mr_findAll() as! [Row]
    }
    
//MARK: - Crop Management Methods
    
    public func getAllCrops() -> [Crop] {
        
        return  Crop.mr_findAll() as! [Crop]
     
    }
    
    public func getMyCrops() -> [Crop]? {
        
        //TODO : Implement MagicalRecord fetch for all Crops
        let ownedCrops = NSPredicate(format: "owned == true")
        let crops = Crop.mr_findAll(with: ownedCrops)
       
        return crops as! [Crop]?
    }
    
    //TODO Optimize the following codes. They are quite repetitive!
    
    public func addCropsToGarden(crops: [Crop]) {
        
        let names = crops.map { $0.name }
        
        let ownedCrop = NSPredicate(format: "name IN %@ AND owned == false", argumentArray: names)
        
        let myCrops = Crop.mr_findAll(with: ownedCrop)
    
        for element in myCrops! { (element as! Crop).owned = true }
        
        saveContext()
        
    }
    
    public func addCropToGarden(crop: Crop) {
       
        let ownedCrop = NSPredicate(format: "name == %@ AND owned == false", argumentArray: [crop.name])
        
        let crop = Crop.mr_findFirst(with: ownedCrop)
        
        crop?.owned = true
        
        saveContext()
       
    }
    
    public func removeCropsFromGarden(crops: [Crop]) {
        
        let names = crops.map { $0.name }
        
        let ownedCrop = NSPredicate(format: "name IN %@ AND owned == true", argumentArray: names)
        
        let myCrops = Crop.mr_findAll(with: ownedCrop)
        
        for element in myCrops! { (element as! Crop).owned = false }
        
        saveContext()
        
    }
    
    public func removeCropFromGarden(crop: Crop) {
        
        let ownedCrop = NSPredicate(format: "name == %@ AND owned == true", argumentArray: [crop.name])
        
        let crop = Crop.mr_findFirst(with: ownedCrop)
        
        crop?.owned = false
        
        saveContext()
        
    }

//MARK: - LifeCycle Methods
    
    public func plant(crop: Crop, in row:Row,  of paddock: Paddock, asA:plantingStates.begining) -> Row {
        
        let plantingCrop = crop.duplicateAssociated()
        
        let state : CropState = (asA == plantingStates.begining.Seed ? Seed.mr_createEntity()! : Seedling.mr_createEntity()!)
        
        state.date = NSDate()
        plantingCrop?.addToStates(state)
        
        plantingCrop?.row = row
        row.addToCrops(plantingCrop!)
        
        if row.length != nil {
        
            row.estimatedNumberOfCrops = NSNumber(value:round((row.length?.floatValue)! / Float(crop.spacing)))
        }
        
        
        let harvestDate = plantingCrop?.getEstimatedHarvestDate()
        let dayPlanted = plantingCrop?.getDayPlanted()
        let daysPassed = plantingCrop?.getDaysPassedSincePlanted()
        let daysToHarvest = plantingCrop?.getEstimatedDaysLeftToHarvest()
        
        
        return row
    }

    public func makeGrowingAction(action:GrowingActions, to row:Row, in paddock: Paddock) {
        
        let actionMade : RowLifeState

        switch action {
            
        case GrowingActions.WeedAction:
            
            actionMade = Weed.mr_createEntity()!
            
        case GrowingActions.WaterAction:
            
            actionMade = Irrigated.mr_createEntity()!
            
        case GrowingActions.FertilizeAction:
            
            actionMade = Fertilized.mr_createEntity()!
        }
        
        actionMade.isDone = true
        actionMade.when = NSDate()
        
        //Not quite the right name for this, but a growing action taken on a row, it modifies its row cycle state.
        row.addToLifeCycleState(actionMade)
    }
    
    
    public func harvest(crop: Crop, from paddock: Paddock) {
       
        let harvestingState = Harvesting.mr_createEntity()
        harvestingState?.date = NSDate()
        crop.addToStates(harvestingState!)
        
    }
    
    public func finishHarvestFor(crop: Crop, in paddock: Paddock) {
        
        let harvestedState = Harvested.mr_createEntity()
        harvestedState?.date = NSDate()
        crop.addToStates(harvestedState!)
        
    }
    
    public func makeAction(action:GrowingActions, in paddock: Paddock) {
        
    }
    
    public func makeAction(in garden: Garden) {
        
    }
    
    
//MARK: - Helper Methods
    
    public func populateDB() {
   
        var crops = [Crop]()
        if let URL = Bundle.main.url(forResource: "AllCrops", withExtension: "plist") {
            
            if let cropsFromPlist = NSArray(contentsOf: URL) {
                
                for dictionary in cropsFromPlist {
                    let crop = Veggie.getCropFrom(dictionary: dictionary as! NSDictionary)
                    
                    crops.append(crop)
                }
            }
        }
        
        saveContext()
    }
    
    public func generateASampleGarden() {
        
        let paddocks = createSamplePaddocks()
        
        let sampleGarden = createGardenNamed(name: "Sample Garden", in: nil, withPaddocks: paddocks)
    
        addRows(numberOfRows: 10, to: paddocks[0], in: sampleGarden)
        
        addRows(numberOfRows: 5, to: paddocks[1], in: sampleGarden)
        
        addRows(numberOfRows: 8, to: paddocks[2], in: sampleGarden)
        
        let cropToPlant = Crop.mr_findFirst()
        let paddock = paddocks[0]
        
        let plantedRow = plant(crop: cropToPlant!,
                                in: paddock.rows?.allObjects.first as! Row,
                                of: paddock,
                                asA: plantingStates.begining.Seed)
        
        
        let rowsFromFirstPaddock = (sampleGarden.paddocks?.allObjects[0] as! Paddock).rows
        
       // let plantedRow = (rowsFromFirstPaddock?.allObjects.first as! Row).lifeCycleState
        
        print("all good : \(plantedRow)")
        
        
        
        
    }
    public func createSamplePaddocks () -> [Paddock] {
        
        let paddock1 = Paddock.mr_createEntity()
        let paddock2 = Paddock.mr_createEntity()
        let paddock3 = Paddock.mr_createEntity()
        
        
        paddock1?.paddockId = UUID().uuidString
        paddock2?.paddockId = UUID().uuidString
        paddock3?.paddockId = UUID().uuidString
        
        paddock1?.name = "Paddock 1"
        paddock2?.name = "Paddock 2"
        paddock3?.name = "Paddock 3"
        
        paddock1?.location = nil
        paddock2?.location = nil
        paddock3?.location = nil
        
        paddock1?.soil = nil
        paddock2?.soil = nil
        paddock3?.soil = nil
        
        return [paddock1!, paddock2!, paddock3!]
        
    }
}
