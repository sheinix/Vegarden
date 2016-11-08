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
        stackView.alignment = .leading
        
        
        
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
        
        cropSizeValue.layer.borderColor = UIColor.red.cgColor
        cropSizeValue.layer.borderWidth = 2
        
        let plantingDirectionsValue = CropDetailText()
        let plantingCompanionsValue = CropDetailText()
        let growingTipsValue        = CropDetailText()
        let potentialProblemsValue  = CropDetailText()
        let diseasesValue           = CropDetailText()
        let harvestTipsValue        = CropDetailText()
        let storageAndUseValue      = CropDetailText()
        
        cropSizeValue.text           = crop.cropSize
        cropSizeValue.backgroundColor = UIColor.red
        plantingDirectionsValue.text = crop.plantingDirections
        plantingCompanionsValue.text = crop.plantingCompanions
        growingTipsValue.text        = crop.growingTips
        potentialProblemsValue.text  = crop.potentialProblems
        diseasesValue.text           = crop.diseases
        harvestTipsValue.text        = crop.harvestTips
        storageAndUseValue.text      = crop.storageAndUse

        
        
        stackView.addArrangedSubview(createSquareView(title: cropSizeLabel, value: cropSizeValue))
        stackView.addArrangedSubview(createSquareView(title: plantingDirections, value: plantingDirectionsValue))
        stackView.addArrangedSubview(createSquareView(title: plantingCompanions, value: plantingCompanionsValue))
        stackView.addArrangedSubview(createSquareView(title: growingTips, value: growingTipsValue))
        stackView.addArrangedSubview(createSquareView(title: potentialProblems, value: potentialProblemsValue))
        stackView.addArrangedSubview(createSquareView(title: diseases, value: diseasesValue))
        stackView.addArrangedSubview(createSquareView(title: harvestTips, value: harvestTipsValue))
        stackView.addArrangedSubview(createSquareView(title: storageAndUse, value: storageAndUseValue))
        
    }
    
    private func createSquareView(title: UILabel, value: UILabel) -> UIView {
        
        
        
        let squareView = UIView()
        squareView.addSubview(title)
        squareView.addSubview(value)
        
        title.sizeToFit()
        value.sizeToFit()
        value.numberOfLines = 0
        
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        value.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.topMargin.equalTo(title.snp.bottomMargin)
        }
        
       
        
       
        
        
        return squareView
        
    }
}
