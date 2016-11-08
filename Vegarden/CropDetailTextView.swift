//
//  CropDetailTextView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 7/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class CropDetailTextView: UIView {

    var stackView: UIStackView!
    
    init(frame: CGRect, crop: Crop) {
        
        super.init(frame: frame)
        
        stackView = UIStackView(frame: frame)
        self.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        stackView.layer.borderColor = UIColor.red.cgColor
        stackView.layer.borderWidth = 2
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        
        
        setupLabelsWith(crop: crop)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabelsWith(crop: Crop) {
        
        let cropSizeLabel      = CropDetailLabel()
        let plantingDirections = CropDetailLabel()
        let plantingCompanions = CropDetailLabel()
        let growingTips        = CropDetailLabel()
        let potentialProblems  = CropDetailLabel()
        let diseases           = CropDetailLabel()
        let harvestTips        = CropDetailLabel()
        let storageAndUse      = CropDetailLabel()
        
        cropSizeLabel.text      = "Crop Size"
        plantingDirections.text = "Planting Directions"
        plantingCompanions.text = "Planting Companions"
        growingTips.text        = "Growing Tips"
        potentialProblems.text  = "Potential Problems"
        diseases.text           = "Diseases"
        harvestTips.text        = "Harvest Tips"
        storageAndUse.text      = "Storage & Use"
        
        let cropSizeValue           = CropDetailText()
        let plantingDirectionsValue = CropDetailText()
        let plantingCompanionsValue = CropDetailText()
        let growingTipsValue        = CropDetailText()
        let potentialProblemsValue  = CropDetailText()
        let diseasesValue           = CropDetailText()
        let harvestTipsValue        = CropDetailText()
        let storageAndUseValue      = CropDetailText()
        
        cropSizeValue.text           = crop.cropSize
        plantingDirectionsValue.text = crop.plantingDirections
        plantingCompanionsValue.text = crop.plantingCompanions
        growingTipsValue.text        = crop.growingTips
        potentialProblemsValue.text  = crop.potentialProblems
        diseasesValue.text           = crop.diseases
        harvestTipsValue.text        = crop.harvestTips
        storageAndUseValue.text      = crop.storageAndUse

        stackView.addArrangedSubview(cropSizeLabel)
        stackView.addArrangedSubview(cropSizeValue)
        stackView.addArrangedSubview(plantingDirections)
        stackView.addArrangedSubview(plantingDirectionsValue)
        stackView.addArrangedSubview(plantingCompanions)
        stackView.addArrangedSubview(plantingCompanionsValue)
        stackView.addArrangedSubview(growingTips)
        stackView.addArrangedSubview(growingTipsValue)
        stackView.addArrangedSubview(potentialProblems)
        stackView.addArrangedSubview(potentialProblemsValue)
        stackView.addArrangedSubview(diseases)
        stackView.addArrangedSubview(harvestTips)
        stackView.addArrangedSubview(harvestTipsValue)
        stackView.addArrangedSubview(storageAndUse)
        stackView.addArrangedSubview(storageAndUseValue)
        
    }
}
