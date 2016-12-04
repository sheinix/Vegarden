//
//  PlantDTO.swift
//  Vegarden
//
//  Created by Sarah Cleland on 18/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import UIKit


struct PlantDTO {
    
    var rows : [Row]!
    var crop : Crop!
    var notes : String?
    var state : plantingStates!
    
    
    init(with rows: [Row], crop: Crop, notes: String?, and state: plantingStates) {
        
        self.rows = rows
        self.crop = crop
        self.notes = notes
        self.state = state
    }
    
}
