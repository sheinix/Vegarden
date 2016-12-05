//
//  GardenManagerExtension.swift
//  Vegarden
//
//  Created by Sarah Cleland on 11/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation

extension GardenManager : PersistanceCallBackProtocol {
    
    
    func didPlant(crop: Crop, in rows: [Row]) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationIds.NotiKeyCropPlanted), object: crop, userInfo: ["crop" : crop])

    }
    
    func didRemoveCropFromGarden(crop: Crop) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationIds.NotiKeyCropRemoved), object: crop, userInfo: ["crop" : crop])
    }
    
    func didAddCropToGarden(crop: Crop) {
        
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationIds.NotiKeyCropAdded), object: crop, userInfo: ["crop" : crop])
        
    }
    
    
    
    func didFinishHarvestFor(crop: Crop) {
        
    }
    
    func didHarvest(action: ActionMadeDTO) {
        
        //Just use didGrowingAction for NOW,because I need to do exactly the same as a growing action made when I harvest.
        didGrowingAction(action: action)
    }
    
    func didGrowingAction(action: ActionMadeDTO) {
    
        //let notiName = NotificationIds().notiIdForGrowing(action: action.actionMade)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationIds.NotiKeyGrowingActionMade),
                                      object: action,
                                      userInfo: ["action" : action])
        
    }
    
    func didUnPlant(crop: Crop?, from rows: [Row], reason: FinishReason) {
        
        let notiObj = NotificationIds.cropRow(crop: crop,
                                              rows: rows,
                                        isFinished: (reason == .FinishHarvesting))
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationIds.NotiKeyCropUnPlanted),
                                        object: rows,
                                        userInfo: ["notiObj" : notiObj])

        
    }
    
    func didAdd(paddock: Paddock!) {
       
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationIds.NotiKeyNewPatch),
                                        object: paddock,
                                        userInfo: ["patch" : paddock])

    }
    
    func didUpdate(paddock: Paddock!) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationIds.NotiKeyPatchEdited),
                                        object: paddock,
                                        userInfo: ["patch" : paddock])
    }
    
    func didDelete(paddock: Paddock!) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationIds.NotiKeyPatchDeleted),
                                        object: paddock,
                                        userInfo: ["patch" : paddock])
    }
    
    func didAdd(rows:[Row]) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationIds.NotiKeyRowsAdded),
                                        object: rows,
                                        userInfo: ["rows" : rows])
    }
    
    func didRemove(rows:[Row]) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationIds.NotiKeyRowsDeleted),
                                        object: rows,
                                        userInfo: ["rows" : rows])
    }
    
    func didUpdate(rows:[Row]) {
       
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationIds.NotiKeyRowsEdited),
                                        object: rows,
                                        userInfo: ["rows" : rows])
    }

    
    
}
