//
//  Veggie+CoreDataClass.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/26/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import CoreData


public class Veggie: Crop {

    public class override func getCropFrom(dictionary: NSDictionary) -> Veggie {
        
        let veggie = super.getCropFrom(dictionary: dictionary)
       // veggie.typeCrop = CropTypes.Veggie
        
        return veggie as! Veggie
    }

}
