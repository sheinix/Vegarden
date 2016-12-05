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
    
    public func createGardenNamed(name: String!, in location:Location?) -> Garden {
        
        let newGarden = Garden.mr_createEntity()
        
        newGarden?.name = name
        
//        newGarden?.addToPaddocks(NSSet(array: paddock!))
//        _ = newGarden?.paddocks?.allObjects.map { ($0 as! Paddock).garden = newGarden }
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
    
    public func update(paddock: Paddock!, data: PatchInfo) {
        
        if let name = data.name { paddock.name = name }
        
        if let location = data.location { paddock.location?.locationName = location }
        
        if let phLevel = data.phLevel {
            
            //TODO Validate that is number!!
            paddock.soil?.phLevel = Double(phLevel)!
        }
        
        if let rowNamePfx = data.rowNamesPrefix {
        //TODO Validate that is number!!    
            paddock.rowsNamePrefix = rowNamePfx
        
        }
        
        if let numRows = data.rowQtty {
            
            guard let patchRows = paddock?.rows?.count else { return }
            
            //Adding new rows case:
            if (numRows > patchRows) { addRows(numberOfRows: (numRows - patchRows), to: paddock) }
            
            else if (numRows < patchRows) && (numRows >= paddock.plantedRows.count ) { //Deleting case
                
                let rowsToDelete : [Row] = paddock.freeRows
                let plantedCount = paddock.plantedRows.count
                
                let limit = (numRows != plantedCount ? numRows - plantedCount : 1)
                
                
                for idx in 0...limit {
                    
                        rowsToDelete[idx].reset()
                        rowsToDelete[idx].mr_deleteEntity()
                }
            }
        }
        
        saveContext()
        
        self.callBackDelegate?.didUpdate(paddock: paddock)
        
    }
    
    public func addPaddock(paddockInfo: PatchInfo) {
        
        let myGarden = self.getAllGardens()[0]
        
        let paddock = Paddock.mr_createEntity()
        let location = PaddockLocation.mr_createEntity()
        let soil = Soil.mr_createEntity()
        
        location?.locationName = paddockInfo.location
        soil?.phLevel = Double(paddockInfo.phLevel!)!
        
        paddock?.name = paddockInfo.name
        paddock?.location = location
        paddock?.soil = soil
        paddock?.rowsNamePrefix = paddockInfo.rowNamesPrefix
        
        addRows(numberOfRows: paddockInfo.rowQtty!, to: paddock!)
        
        paddock!.garden = myGarden
        
        myGarden.addToPaddocks(paddock!)
        
        saveContext()
        
        self.callBackDelegate?.didAdd(paddock: paddock)
        
    }
    
    public func removePaddocks(paddocks:[Paddock], from garden: Garden) {
        
        paddocks.forEach({ $0.mr_deleteEntity() })
    }
    
    public func removePatch(patch: Paddock) {
        
        //TODO Check if all the rows needs to be deleted aswell!
        patch.mr_deleteEntity()
        
        saveContext()
        
        self.callBackDelegate?.didDelete(paddock: patch)
    }
    
    public func getAllPaddocks() -> [Paddock] {
        
        return Paddock.mr_findAll() as! [Paddock]
    }
    
// MARK: - Row Management Methods
    
    public func editRows(rows: [Row]) {
        
        saveContext()
        
        self.callBackDelegate?.didUpdate(rows: rows)

    }

    
    public func addRow(rowName: String!, length: Float?, to paddock: Paddock) -> Row {
        
        let newRow = Row.mr_createEntity()
        newRow?.name = rowName
        newRow?.id = UUID().uuidString
        newRow?.length = (length == nil ? 0 : length!)
        newRow?.paddock = paddock
        paddock.addToRows(newRow!)
        
        saveContext()
        
        return newRow!
        
    }
    
    public func addRows(rows:[newRow], patch: Paddock!) {
        
        var newRows : [Row] = []
        
        rows.forEach { (newRow) in
            
            newRows.append(addRow(rowName: newRow.name, length: nil, to: patch))
        }
        
        self.callBackDelegate?.didAdd(rows: newRows)
    }
    
    public func addRows(numberOfRows: Int, to paddock: Paddock) {
        
        //var newRows : [Row] = []
        
        //var rowName : String
        let rowPrefix = paddock.rowsNamePrefix
        
        for _ in (0..<numberOfRows) {
 
            //TODO Check helper method to see how can i get the randoms with a fixed length
//            rowName = "V_"+String(HelperManager.random(digits: 5))
            
            _ = addRow(rowName: rowPrefix!+String(arc4random()),
                                    length: nil,
                                        to: paddock)
            
        }
        
       // self.callBackDelegate?.didAdd(rows: newRows)
    }
    
    public func deleteRows(rows: [Row]) {
        
        //TODO Check if necessesary to delete de life states of the rows before, or its cascade delteing!
         rows.forEach { (row) in
            row.lifeCycleState?.forEach( { ($0 as! RowLifeState).mr_deleteEntity() } )
            row.mr_deleteEntity()
        }
        
        
        self.callBackDelegate?.didRemove(rows: rows)
    }
    
//    public func removeRow(row: Row, from paddock: Paddock, in garden: Garden) {
//        
//        row.mr_deleteEntity()
//        
//    }
    
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
    

    
    public func makeGrowingAction(action: ActionMadeDTO) {
        
        switch action.actionMade! {
        
        case GrowingActions.UnplantAction:
            unplant(crop: action.crop, at: action.rows, with: .CropWasted)
        case GrowingActions.FinishAction:
            unplant(crop: action.crop, at: action.rows, with: .FinishHarvesting)
        case GrowingActions.HarvestAction:
            harvest(action: action)
            
        default:
            makeGrowing(action: action)
        }
    }
    
    private func harvest(action:ActionMadeDTO) {

        guard let state = Harvesting.mr_createEntity() else { return }

        state.date = NSDate()
        if let note = action.notes {
            state.notes = note as NSString?
        }
        
        action.crop.addToStates(state)
        
        saveContext()
        
        self.callBackDelegate?.didHarvest(action: action)
    }
    
    private func makeGrowing(action: ActionMadeDTO) {
        
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
    
    private func unplant(crop: Crop, at rows: [Row], with reason: FinishReason) {
        
        rows.forEach { $0.reset() }
        
        let clearCrop = (crop.row?.count == 0)
        
        if (clearCrop) {  crop.mr_deleteEntity()  }
        
        saveContext()

        self.callBackDelegate?.didUnPlant(crop: crop, from: rows, reason: reason )
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
        
       // let paddocks = createSamplePaddocks()
        
        
        
        let sampleGarden = createGardenNamed(name: "Sample Garden", in: nil)
    
        //addRows(numberOfRows: 10, to: sampleGarden.paddocks?.allObjects[0] as! Paddock)
        
       // addRows(numberOfRows: 5, to: sampleGarden.paddocks?.allObjects[1] as! Paddock)
        
       // addRows(numberOfRows: 8, to: sampleGarden.paddocks?.allObjects[2] as! Paddock)
        
        saveContext()
        
        
    }
//    public func createSamplePaddocks () -> [Paddock] {
//        
//        let paddock1 = Paddock.mr_createEntity()
//        
//        let paddock2 = Paddock.mr_createEntity()
//        let paddock3 = Paddock.mr_createEntity()
//        
//        
//        
//        
//        
//        paddock1?.paddockId = UUID().uuidString
//        paddock2?.paddockId = UUID().uuidString
//        paddock3?.paddockId = UUID().uuidString
//        
//        paddock1?.name = "Paddock 1"
//        paddock2?.name = "Paddock 2"
//        paddock3?.name = "Paddock 3"
//        
//        paddock1?.location = nil
//        paddock2?.location = nil
//        paddock3?.location = nil
//        
//        paddock1?.soil = nil
//        paddock2?.soil = nil
//        paddock3?.soil = nil
//        
//        saveContext()
//        
//        return [paddock1!, paddock2!, paddock3!]
//        
//    }
}
