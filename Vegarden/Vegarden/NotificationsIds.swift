//
//  NotificationsIds.swift
//  Vegarden
//
//  Created by Sarah Cleland on 4/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation

struct NotificationIds {
    
    static let NotiKeyCropRemoved       = "CropRemoved"
    static let NotiKeyCropAdded         = "CropAdded"
    static let NotiKeyCropPlanted       = "CropPlanted"
    static let NotiKeyCropUnPlanted     = "CropUnPlanted"
    static let NotiKeyCropWeeded        = "CropWeeded"
    static let NotiKeyCropIrrigated     = "CropIrrigated"
    static let NotiKeyCropFertilized    = "CropFertilized"
    static let NotiKeyCropHarvested     = "CropHarvested"
    static let NotiKeyGrowingActionMade = "GrowingActionMade"
    static let NotiKeyCropFinished      = "CropFinished"

    static let NotiKeyRowsEdited        = "RowsEdited"
    static let NotiKeyRowsAdded         = "RowsAdded"
    static let NotiKeyRowsDeleted       = "RowsDeleted"
    
    static let NotiKeyPatchEdited       = "PatchEdited"
    static let NotiKeyNewPatch          = "NewPatch"
    static let NotiKeyPatchDeleted : String  = "PatchDeleted"
    
    
    struct cropRow {
        var crop: Crop?
        var rows: [Row]
        var isFinished : Bool
    }
    
    
       
    public func notiIdForGrowing(action: GrowingActions) -> String {
        
        var notiId : String?
        
        switch action {
        case GrowingActions.FertilizeAction:
            notiId = NotificationIds.NotiKeyCropFertilized
            
        case GrowingActions.WaterAction:
            notiId = NotificationIds.NotiKeyCropIrrigated
            
        case GrowingActions.WeedAction:
            notiId = NotificationIds.NotiKeyCropWeeded
            
        case GrowingActions.HarvestAction:
            
            notiId = NotificationIds.NotiKeyCropHarvested
            
        case GrowingActions.FinishAction:
            notiId = NotificationIds.NotiKeyCropFinished
            
        default:
            notiId = nil
        }
        
        return notiId!
    }
    
}
