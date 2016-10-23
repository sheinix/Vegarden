//
//  PersitanceCallBackProtocol.swift
//  Vegarden
//
//  Created by Sarah Cleland on 23/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation


protocol PersistanceCallBackProtocol: class {
    
    func didHarvest(crop:Crop)
    
    func didFinishHarvestFor(crop: Crop)
    
    func didGrowingAction(action: GrowingActions, on row: Row)
    
    func didPlant(crop: Crop, in row: Row)
    
    //TODO Finish the protocol methods!
}
