//
//  CropInformationView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 7/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class CropInformationView: UIView {
    
    @IBOutlet weak var plantingDirectionsTitle: UILabel!
    @IBOutlet weak var plantingDirectionsText: UILabel!
    
    @IBOutlet weak var plantingCompanionsTitle: UILabel!
    @IBOutlet weak var plantingCompanionsText: UILabel!
    
    @IBOutlet weak var growingTipsTitle: UILabel!
    @IBOutlet weak var growingTipsText: UILabel!
    
    @IBOutlet weak var harvestTipsTitle: UILabel!
    @IBOutlet weak var harvestTipsText: UILabel!
    
    @IBOutlet weak var storageAndUseTitle: UILabel!
    @IBOutlet weak var storageAndUseText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
        plantingDirectionsText.font = Fonts.cropInfoLabelFont
        plantingCompanionsText.font = Fonts.cropInfoLabelFont
        growingTipsText.font = Fonts.cropInfoLabelFont
        harvestTipsText.font = Fonts.cropInfoLabelFont
        storageAndUseText.font = Fonts.cropInfoLabelFont
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    
    public func setupViewWith(crop: Crop) {
        
        
        plantingDirectionsText.text = crop.plantingDirections
        plantingCompanionsText.text = crop.plantingCompanions
        growingTipsText.text        = crop.growingTips
        harvestTipsText.text        = crop.harvestTips
        storageAndUseText.text      = crop.storageAndUse

    }

    
    
    
}
