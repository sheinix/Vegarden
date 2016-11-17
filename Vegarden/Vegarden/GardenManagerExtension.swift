//
//  GardenManagerExtension.swift
//  Vegarden
//
//  Created by Sarah Cleland on 11/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation

extension GardenManager : PersistanceCallBackProtocol {
    
    
    func didRemoveCropFromGarden(crop: Crop) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationIds.NotiKeyCropRemoved), object: crop, userInfo: ["crop" : crop])
    }
    
    func didAddCropToGarden(crop: Crop) {
        
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationIds.NotiKeyCropAdded), object: crop, userInfo: ["crop" : crop])
        
    }
    
    func didHarvest(crop:Crop) {
        
    }
    
    func didFinishHarvestFor(crop: Crop) {
        
    }
    
    func didGrowingAction(action: GrowingActions, on row: Row) {
        
    }
    
    
    func didPlant(crop: Crop, in row: Row) {
        
    }
    
}
