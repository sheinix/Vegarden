//
//  CropDetailLabelView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 7/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class CropDetailLabelView: UIView {
    
    @IBOutlet weak var familyValue: CropDetailLabel!
    @IBOutlet weak var typeValue: CropDetailLabel!
    @IBOutlet weak var phLevelValue: CropDetailLabel!
    @IBOutlet weak var spacingValue: CropDetailLabel!
    @IBOutlet weak var isInGarden: CropDetailLabel!
    @IBOutlet weak var classificationValue: CropDetailLabel!
    
    
    @IBOutlet weak var cropSizeTitle: UILabel!
    @IBOutlet weak var cropSizeTxt: UILabel!
    @IBOutlet weak var potentialProbemsTitle: UILabel!
    @IBOutlet weak var potentialProblemsText: UILabel!
    @IBOutlet weak var diseasesTitle: UILabel!
    @IBOutlet weak var diseasesText: UILabel!

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
        
    public func setupValuesWith(crop: Crop) {
        
        self.typeValue.text           = crop.cropTypeStringValue
        self.familyValue.text         = crop.family
        self.phLevelValue.text        = crop.phLevels
        self.spacingValue.text        = String(crop.spacing)
        self.isInGarden.text          = (crop.owned ? "Yes" : "No")
        self.classificationValue.text = crop.plantType
        
        self.cropSizeTxt.text            = crop.cropSize
        self.potentialProblemsText.text  = crop.potentialProblems
        self.diseasesText.text           = crop.diseases
        
        self.cropSizeTxt.font           = Fonts.cropInfoLabelFont
        self.potentialProblemsText.font = Fonts.cropInfoLabelFont
        self.diseasesText.font          = Fonts.cropInfoLabelFont
        
        self.cropSizeTitle.font = Fonts.appleGoticUltraLightFont
        self.potentialProbemsTitle.font = Fonts.appleGoticUltraLightFont
        self.diseasesTitle.font = Fonts.appleGoticUltraLightFont
       
    }
}
