//
//  CropLifeCycleTableViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 24/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SnapKit
import MBCircularProgressBar

class CropLifeCycleTableViewCell: FoldingCell {

    @IBOutlet weak var ringProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var cropName: UILabel!
    @IBOutlet weak var datePlanted: UILabel!
    @IBOutlet weak var harvestDate: UILabel!
    
//    @IBOutlet weak var accesoryView: UIView!
    
    var lifeCycleDetailView : LifeCycleDetailiView
    
    required init?(coder aDecoder: NSCoder) {
        
        lifeCycleDetailView = LifeCycleDetailiView()
        
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        foregroundView.layer.borderWidth = 1
        foregroundView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.cornerRadius = 10
//        containerView.layer.masksToBounds = true
//        containerView.layer.borderWidth = 1
//        containerView.layer.borderColor = UIColor.lightGray.cgColor
        
        
      // setupConstraints()
        
        super.awakeFromNib()
    }

    
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    
    
    public func setCellWith(crop: Crop) {
        
        self.cropName.text = crop.name
        self.datePlanted.text = "Date Planted: " + (crop.getDayPlanted()?.inCellDateFormat())!
        self.harvestDate.text = "Harvest Date: " + (crop.getEstimatedHarvestDate().inCellDateFormat())
        
        let progressNumber = CGFloat(integerLiteral: crop.getEstimatedDaysLeftToHarvest())
        
        self.ringProgressBar.setValue(progressNumber, animateWithDuration: 3.0)
        
       
    }
    
    private func setupConstraints() {
        
        
        //RingProgressBar:
//        
//        ringProgressBar.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(8)
//            make.top.equalToSuperview().offset(8)
//            make.bottom.equalToSuperview().offset(8)
//            make.right.equalTo(cropName.snp.left).offset(8)
//        }
//        
//        //CropName label:
//        
//        cropName.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(8)
//            make.bottom.equalTo(datePlanted).offset(4)
//            make.left.equalTo(ringProgressBar.snp.right).offset(8)
//            make.right.equalTo(accesoryView.snp.left).offset(8)
//        }
//        
//        //DatePlanted label:
//        
//        datePlanted.snp.makeConstraints { (make) in
//            make.top.equalTo(cropName.snp.bottom).offset(4)
//            make.bottom.equalTo(harvestDate.snp.top).offset(4)
//            make.left.equalTo(ringProgressBar.snp.right).offset(8)
//            make.right.equalTo(accesoryView.snp.left).offset(8)
//        }
//        
//        //HarvestDate label:
//        
//        harvestDate.snp.makeConstraints { (make) in
//            make.top.equalTo(datePlanted.snp.bottom).offset(4)
//            make.bottom.equalToSuperview().offset(8)
//            make.left.equalTo(ringProgressBar.snp.right).offset(8)
//            make.right.equalTo(accesoryView.snp.left).offset(8)
//        }
//        
//        //AccesoryView:
//        
//        accesoryView.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(8)
//            make.bottom.equalToSuperview().offset(8)
//            make.left.equalTo(ringProgressBar.snp.right).offset(8)
//            make.right.equalTo(accesoryView.snp.left).offset(8)
//        }
        
    }
}
