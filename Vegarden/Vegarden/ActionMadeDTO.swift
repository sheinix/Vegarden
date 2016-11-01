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
    
    
    init(with rows: [Row], crop: Crop, notes: String?, and action: GrowingActions) {
        
        self.rows = rows
        self.crop = crop
        self.notes = notes
        self.actionMade = action
    }

}
