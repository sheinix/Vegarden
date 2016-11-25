//
//  PersitanceCallBackProtocol.swift
//  Vegarden
//
//  Created by Sarah Cleland on 23/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation


protocol PersistanceCallBackProtocol: class {
    
    func didRemoveCropFromGarden(crop: Crop)
    
    func didAddCropToGarden(crop: Crop)
    
    func didHarvest(crop:Crop)
    
    func didFinishHarvestFor(crop: Crop)
    
    func didGrowingAction(action: ActionMadeDTO)
    
    func didUnPlant(crop: Crop?, from rows: [Row])

    func didPlant(crop: Crop, in rows: [Row])
    
    //TODO Finish the protocol methods!
}
