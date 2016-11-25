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

class GardenManager: GardenManagementProtocol {
    

    class var shared: GardenManager {
        
        return sharedGadenManager

    }
    
// MARK: - Garden Management Methods
    
    public func createAGardenNamed(name: String!,
                                   in:Location?,
                withPaddocks paddocks: [Paddock]?) -> Garden {
        
        return PersistenceManager.shared.createGardenNamed(name: name, in: nil, withPaddocks: nil)
    }
    
    public func remove(garden: Garden) {
        
        
        
    }
    
// MARK: - Paddock Management Methods
    
    
    public func addPaddocks(paddocks:[Paddock], to garden: Garden) {
    
        PersistenceManager.shared.addPaddocks(paddocks: paddocks, to: garden)
    }
    
    public func addPaddock(paddock: Paddock, to garden: Garden) {
        
        PersistenceManager.shared.addPaddock(paddock: paddock, to: garden)
    }
    
    public func removePaddocks(paddocks:[Paddock], from garden: Garden) {
        
        PersistenceManager.shared.removePaddocks(paddocks: paddocks, from: garden)
    }
    
    public func removePaddock(paddock: Paddock, from garden: Garden) {
        
        PersistenceManager.shared.removePaddock(paddock: paddock, from: garden)
    }
    
// MARK: - Row Management Methods
    
    public func addRow(rowName: String!, length: Float?, to paddock: Paddock, in garden: Garden) {
        
        PersistenceManager.shared.addRow(rowName: rowName, length: length, to: paddock, in: garden)
        
    }
    
    public func addRows(numberOfRows: Int, to paddock: Paddock, in garden: Garden) {
        
        PersistenceManager.shared.addRows(numberOfRows: numberOfRows, to: paddock, in: garden)
    }
    
    public func removeRow(row: Row, from paddock: Paddock, in garden: Garden) {
        
        PersistenceManager.shared.removeRow(row: row, from: paddock, in: garden)
    }
    
    public func removeRows(rows: [Row], from paddock: Paddock, in garden: Garden) {
        
        PersistenceManager.shared.removeRows(rows: rows, from: paddock, in: garden)
    }
    
// MARK: - Crop Management Methods
    
    public func addNewCropsToGarden(crops: [Crop]) {
        
        PersistenceManager.shared.addCropsToGarden(crops: crops)
        
    }
    
    public func addNewCropToGarden(crop: Crop) {
        
        PersistenceManager.shared.addCropToGarden(crop: crop)
    }
    
    public func removeCropFromGarden(crop:Crop) {
        
        PersistenceManager.shared.removeCropFromGarden(crop: crop)
        
    }
    
    public func removeCropsFromGarden(crops:[Crop]) {
        
        PersistenceManager.shared.removeCropsFromGarden(crops: crops)
    
    }
    
    
// MARK: - Getter Methods
    
    public func allCrops() -> [Crop] {
     
        return PersistenceManager.shared.getAllCrops()
        
    }
    
    public func myCrops() -> [Crop] {
        
        return PersistenceManager.shared.getCrops(owned: true)
    }
    
    public func unowedCrops() -> [Crop] {
        
        return PersistenceManager.shared.getCrops(owned: false)
    }
    
    public func myPlantedCrops() -> [Crop]? {
        
        return PersistenceManager.shared.getPlantedCrops()
    }
    
    public func getMyGarden() -> Garden {
        
        return PersistenceManager.shared.getAllGardens()[0]
    
    }
    
    public func getAllPaddocks() -> [Paddock] {
        
        return PersistenceManager.shared.getAllPaddocks()
    }
    
    public func getAllRows() -> [Row] {
        
        return PersistenceManager.shared.getAllRows()
    }
    
    public func getAllRowsWhere(planted: Bool) -> [Row] {
        
        return (planted ? PersistenceManager.shared.getAllPlantedRows() :
                          PersistenceManager.shared.getAllFreeRows())
        
    }
    
//MARK: - Action Mehotds
    
    //TODO Improve this call, 
    public func make(action: GrowingActions, in crop: Crop, with unit: [Row]) {
        
        //TODO Improve this!
        PersistenceManager.shared.makeGrowingAction(action: action, in: (crop.row?.allObjects[0] as! Row).paddock!)
    }
    
    public func make(action: ActionMadeDTO) {
        
        PersistenceManager.shared.makeGrowingAction(action: action)
  
    }
    
    public func plant(plantAction: PlantDTO) {
     
       PersistenceManager.shared.plant(plantAction: plantAction)
        
       
    }
}
