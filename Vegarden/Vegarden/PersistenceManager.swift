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
    
    weak var callBackDelegate: PersistanceCallBackProtocol? = GardenManager.shared
    
    
// MARK: - CoreData/MagicalRecord Methods
    
    public func getContext() -> NSManagedObjectContext {
        
        return NSManagedObjectContext.mr_default()
    }
    
    
    public func setupPersistanceStack() -> Void {
        
        print("set the magical record setupcoredatasatack")
        
        MagicalRecord.setupCoreDataStack(withStoreNamed: "Vegarden")
        
        if (UserDefaults.isFirstLaunch()) {
            populateDB()
            generateASampleGarden()
            saveContext()
        }

        print("done ok")
    }
 
    public func saveContext() {
        
        //TODO Try to see how to save on background, because now is blocking the main thread for saving
        
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        

        print ("all good")
            

    }

//MARK: - Garden Management Methods
    
    public func createGardenNamed(name: String!, in location:Location?, withPaddocks paddock: [Paddock]?) -> Garden {
        
        let newGarden = Garden.mr_createEntity()
        
        newGarden?.name = name
        
        //_ = paddock?.map { ($0 as Paddock).garden = garden }
        
        newGarden?.addToPaddocks(NSSet(array: paddock!))
        _ = newGarden?.paddocks?.allObjects.map { ($0 as! Paddock).garden = newGarden }
        newGarden?.location = location
        
        saveContext()
        
        //TODO FIX IT: When saving context the paddoc.garden = garden relationship is lost!
        
        return newGarden!
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
        newRow?.length = (length == nil ? 0 : length!)
        newRow?.paddock = paddock
        paddock.addToRows(newRow!)
        
        saveContext()
        
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
    
    public func getAllPlantedRows() -> [Row] {
        
        let rows = getAllRows()
        
        return rows.filter { (($0 as Row).crops?.count)! > 0 }
        
    }
    
    public func getAllFreeRows() -> [Row] {
        
        let rows = getAllRows()
        
        return rows.filter { (($0 as Row).crops?.count)! == 0 }
        
    }
    
//MARK: - Crop Management Methods
    
    
    // Gets all the crops whos instances aren't planted. Just for the MyCropsScreen
    public func getAllCrops() -> [Crop] {
  
        let crops = Crop.mr_findAll()
        
        let distinct : [Crop] = crops?.filter({ (crop) -> Bool in
            (crop as! Crop).states?.count == 0
        }) as! [Crop]

        return  distinct
     
    }
    
    public func getCrops(owned: Bool) -> [Crop] {
        
        let crops = getAllCrops().filter { $0.owned == owned }
        
        return crops 
    }
        
    public func getPlantedCrops() -> [Crop]? {
    
        //TODO Get the crops that are planted! Return [] si no hay
        
        var myPlantedCrops : [Crop]? = []
        
        let myRows = Row.mr_findAll()
        
       myRows?.forEach({ (row) in
        
        
            if  ((row as! Row).crops?.anyObject() != nil) {
                
                let crop : Crop = (row as! Row).crops?.anyObject() as! Crop
                 
                if ((myPlantedCrops?.index(of: crop)) == nil) { //Need to check if its already added!
                    
                    myPlantedCrops?.append(crop)
                }
            }
       })
        
        return myPlantedCrops

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
       
        let ownedCrop = NSPredicate(format: "name == %@ AND owned == false", argumentArray: [crop.name!])
        
        if let crop = Crop.mr_findFirst(with: ownedCrop) {
            
            if (crop.row?.count == 0)  {
                crop.owned = true
                saveContext()
                
                callBackDelegate?.didAddCropToGarden(crop: crop)
            }
        }
    }
    
    public func removeCropsFromGarden(crops: [Crop]) {
        
        let names = crops.map { $0.name }
        
        let ownedCrop = NSPredicate(format: "name IN %@ AND owned == true", argumentArray: names)
        
        let myCrops = Crop.mr_findAll(with: ownedCrop)
        
        for element in myCrops! { (element as! Crop).owned = false }
        
        saveContext()
        
    }
    
    public func removeCropFromGarden(crop: Crop) {
        
        let ownedCrop = NSPredicate(format: "name == %@ AND owned == true", argumentArray: [crop.name!])
        
        let crop = Crop.mr_findFirst(with: ownedCrop)
        
        crop?.owned = false
        
        saveContext()
        
        callBackDelegate?.didRemoveCropFromGarden(crop: crop!)
        
    }
    
//    public func removePlantedCrop(crop: Crop)
    
    
//MARK: - LifeCycle Methods
    
    public func plant(plantAction: PlantDTO) {
        
        let plantingCrop = plantAction.crop.duplicateAssociated()!
        let plantingType = plantAction.state
        let rows         = plantAction.rows!
        
        let state : CropState = (plantingType == plantingStates.Seed ? Seed.mr_createEntity()! : Seedling.mr_createEntity()!)
        
        state.date = NSDate()
        state.notes = plantAction.notes as NSString?
        plantingCrop.addToStates(state)
        
        for row in rows {
            
            plantingCrop.addToRow(row)
            row.addToCrops(plantingCrop)
            row.estimatedNumberOfCrops = Int16(NSNumber(value:round((row.length) / Float((plantingCrop.spacing)))))
        }
        
        saveContext()
        
        self.callBackDelegate?.didPlant(crop: plantingCrop, in: rows)
    }
    
    
    public func plant(crop: Crop, in row:Row,  of paddock: Paddock, asA:plantingStates) -> Row {
        
        let plantingCrop = crop.duplicateAssociated()
        
        saveContext()
        
        let state : CropState = (asA == plantingStates.Seed ? Seed.mr_createEntity()! : Seedling.mr_createEntity()!)
    
        state.date = NSDate()
        plantingCrop?.addToStates(state)
        
        //TODO ReCalculate time to harvest depending on how was planted (seed or seedling()
        
        plantingCrop?.addToRow(row)
        
        row.addToCrops(plantingCrop!)
        
       // if row.length != nil {
        
            row.estimatedNumberOfCrops = Int16(NSNumber(value:round((row.length) / Float((plantingCrop?.spacing)!))))
        //}
        
        //TODO Clean this
        _ = plantingCrop?.getEstimatedHarvestDate()
        _ = plantingCrop?.getDayPlanted()
        _ = plantingCrop?.getDaysPassedSincePlanted()
        _ = plantingCrop?.getEstimatedDaysLeftToHarvest()
        
        saveContext()
        
        return row
    }

    public func makeGrowingAction(action:GrowingActions, to row:Row, in paddock: Paddock) {
        
        //Not quite the right name for this, but a growing action taken on a row, it modifies its row cycle state.
        row.addToLifeCycleState(getStateFor(action: action))
        
        saveContext()
        
    }
    
    public func makeGrowingAction(action:GrowingActions, in paddock: Paddock) {
        
        paddock.rows?.forEach({ (row) in
            makeGrowingAction(action: action, to:row as! Row, in: paddock)
        })
        
    }
    
    public func makeGrowingAction(action: GrowingActions, in garden: Garden) {
        
        garden.paddocks?.forEach({ (paddock) in
            makeGrowingAction(action: action, in: paddock as! Paddock)
        })
    }
    
    public func makeGrowingAction(action: ActionMadeDTO) {
        
        if (action.actionMade == GrowingActions.UnplantAction) {
            
            unplant(crop: action.crop, at: action.rows)
        
        } else {
        
            //Need to create a new state for each row, because i can remove rows from crop while planted
            action.rows.forEach { (row) in
                
                let state = getStateFor(action: action.actionMade)
                
                if let note = action.notes {
                    state.notes = note
                }
                
                row.addToLifeCycleState(state)
                state.row = row
                
            }
            
            saveContext()
            self.callBackDelegate?.didGrowingAction(action: action)
        }
    }
    
    private func unplant(crop: Crop, at rows: [Row]) {
        
        rows.forEach { $0.reset() }
        
        let clearCrop = (crop.row?.count == 0)
        
        if (clearCrop) {
            
            crop.mr_deleteEntity()

        }
        
        saveContext()
        
        self.callBackDelegate?.didUnPlant(crop: (clearCrop ? nil : crop), from: rows)
    }
    
    
    public func harvest(crop: Crop, from paddock: Paddock) {
       
        let harvestingState = Harvesting.mr_createEntity()
        harvestingState?.date = NSDate()
        crop.addToStates(harvestingState!)
        
        saveContext()
        
    }
    
    public func finishHarvestFor(crop: Crop, in paddock: Paddock) {
        
        let harvestedState = Harvested.mr_createEntity()
        harvestedState?.date = NSDate()
        crop.addToStates(harvestedState!)
        
        saveContext()
        
    }
    
    
//MARK: - Helper Methods
    
    private func getStateFor(action:GrowingActions) -> (RowLifeState) {
        
        var actionMade : RowLifeState?
        
        
        switch (action) {
            
        case GrowingActions.WeedAction:
            
            actionMade = Weed.mr_createEntity()!
            
        case GrowingActions.WaterAction:
            
            actionMade = Irrigated.mr_createEntity()!
            
        case GrowingActions.FertilizeAction:
            
            actionMade = Fertilized.mr_createEntity()!
        
        default : break
        }
        
        actionMade?.isDone =  true
        actionMade?.when = NSDate()
        
        return actionMade!
    }
    
    
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
    
        addRows(numberOfRows: 10, to: sampleGarden.paddocks?.allObjects[0] as! Paddock, in: sampleGarden)
        
        addRows(numberOfRows: 5, to: sampleGarden.paddocks?.allObjects[1] as! Paddock, in: sampleGarden)
        
        addRows(numberOfRows: 8, to: sampleGarden.paddocks?.allObjects[2] as! Paddock, in: sampleGarden)
        
        saveContext()
        
//        let cropToPlant = Crop.mr_findFirst()
//        cropToPlant?.owned = true
//        let paddock = sampleGarden.paddocks?.allObjects[0] as! Paddock
//        
//        let plantedRow1 = plant(crop: cropToPlant!,
//                                in: paddock.rows?.allObjects.first as! Row,
//                                of: paddock,
//                                asA: plantingStates.Seed)
//        
//        let plantedRow2 = plant(crop: cropToPlant!,
//                               in: paddock.rows?.allObjects.first as! Row,
//                               of: paddock,
//                               asA: plantingStates.Seedling)
//        
//        let plantedRow3 = plant(crop: cropToPlant!,
//                               in: paddock.rows?.allObjects.first as! Row,
//                               of: paddock,
//                               asA: plantingStates.Seed)
//        
//       makeGrowingAction(action: GrowingActions.FertilizeAction, to: plantedRow1, in:plantedRow1.paddock! )
        
     //   harvest(crop: plantedRow.crops?.allObjects[0] as! Crop, from: plantedRow.paddock!)
        
//        print("all good : \(plantedRow1)")
        
        
        
        
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
        
        saveContext()
        
        return [paddock1!, paddock2!, paddock3!]
        
    }
}
