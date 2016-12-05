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
    
    func didHarvest(action:ActionMadeDTO)
    
    func didFinishHarvestFor(crop: Crop)
    
    func didGrowingAction(action: ActionMadeDTO)
    
    func didUnPlant(crop: Crop?, from rows: [Row], reason: FinishReason)

    func didPlant(crop: Crop, in rows: [Row])
    
    func didAdd(paddock: Paddock!)
    
    func didUpdate(paddock: Paddock!)
    
    func didDelete(paddock: Paddock!)
    
    func didAdd(rows:[Row])
    
    func didRemove(rows:[Row])
    
    func didUpdate(rows:[Row])
    
    //TODO Finish the protocol methods!
}
