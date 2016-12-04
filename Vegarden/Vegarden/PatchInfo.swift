//
//  PatchInfo.swift
//  Vegarden
//
//  Created by Sarah Cleland on 4/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation

//Used for add/edit patchs! :
public enum patchEditionRows : Int {
    
    case PatchName, PatchLocation, PatchSoilPhLvl, PatchRowQtty, PatchRowNamesPrefix
}


struct PatchInfo {
    
    var name: String?
    var location: String?
    var phLevel: String?
    var rowQtty: Int?
    var rowNamesPrefix: String?
    
    var isReadyForCreation : Bool {
        
        get {
            return  (name != nil &&
                location != nil &&
                phLevel != nil &&
                rowQtty != nil &&
                rowNamesPrefix != nil)
        }
    }
    
    var hasSomeDataToUpdate : Bool {
        
        get {
            return  (name != nil ||
                location != nil ||
                phLevel != nil ||
                rowQtty != nil ||
                rowNamesPrefix != nil)
        }
    }
    
    
}
