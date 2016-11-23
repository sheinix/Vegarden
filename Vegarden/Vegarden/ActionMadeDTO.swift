//
//  ActionMadeDTO.swift
//  Vegarden
//
//  Created by Sarah Cleland on 1/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import UIKit


class ActionMadeDTO {
    
    var rows : [Row]!
    var crop : Crop!
    var notes : String?
    var actionMade: GrowingActions!
    
    public var screenTitle :  String {
        
        get {
            
            switch self.actionMade! {
                
            case GrowingActions.FertilizeAction:
                
                return self.crop.name! + " Fertilized!"
                
            case GrowingActions.WaterAction:
                
                return self.crop.name! + " Irrigated!"
                
            case GrowingActions.WeedAction:
                
                return self.crop.name! + " Weeded!"
                
            case GrowingActions.HarvestAction:
                
                return self.crop.name! + " Harvested!"
                
            case GrowingActions.FinishAction:
                
                return self.crop.name! + " Finished!"
                
                //            default:
                //                    return self.crop.name! + "!"
            }
        }
    }
    
    
    init(with rows: [Row], crop: Crop, notes: String?, and action: GrowingActions) {
        
        self.rows = rows
        self.crop = crop
        self.notes = notes
        self.actionMade = action
    }

    
    
    
}
