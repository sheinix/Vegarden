//
//  GardenManagementProtocol.swift
//  Vegarden
//
//  Created by Sarah Cleland on 20/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation

protocol GardenManagementProtocol: class {
    
    // MARK: - Garden Management Methods
    
    func createAGardenNamed(name: String!, in:Location?, withPaddocks paddocks: [Paddock]?) -> Garden
    
    func remove(garden: Garden)
    
    // MARK: - Paddock Management Methods
        
    func addPaddocks(paddocks:[Paddock], to garden: Garden)
    
    func addPaddock(paddock: Paddock, to garden: Garden)
   
    func removePaddocks(paddocks:[Paddock], from garden: Garden)
    
    func removePaddock(paddock: Paddock, from garden: Garden)
    
    // MARK: - Row Management Methods
    
    func addRow(rowName: String!, length: Float?, to paddock: Paddock, in garden: Garden)
   
    func addRows(numberOfRows: Int, to paddock: Paddock, in garden: Garden)
   
    func removeRow(row: Row, from paddock: Paddock, in garden: Garden)
   
    func removeRows(rows: [Row], from paddock: Paddock, in garden: Garden)
    
    // MARK: - Crop Management Methods
    
    func addNewCropsToGarden(crops: [Crop])
    
    func addNewCropToGarden(crop: Crop)
   
    func removeCropFromGarden(crop:Crop)
    
    func removeCropsFromGarden(crops:[Crop])
   
    // MARK: - Getter Methods
    
    func allCrops() -> [Crop]
    
    func myOwnedCrops() -> [Crop]?
}
