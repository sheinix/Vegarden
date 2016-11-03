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
import KCFloatingActionButton
import SCLAlertView

class CropLifeCycleTableViewCell: FoldingCell {

    @IBOutlet weak var ringProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var cropName: UILabel!
    @IBOutlet weak var datePlanted: UILabel!
    @IBOutlet weak var harvestDate: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
   
    var actionMenu : KCFloatingActionButton
    var crop : Crop?
    
    
    let items: [(icon: String, color: UIColor)] = [
                    ("icon_weeding", UIColor(red:0.19, green:0.57, blue:1, alpha:1)),
                    ("icon_fertilize", UIColor(red:0.22, green:0.74, blue:0, alpha:1)),
                    ("icon_water", UIColor(red:0.96, green:0.23, blue:0.21, alpha:1)),
                    ("icon_harvest", UIColor(red:0.51, green:0.15, blue:1, alpha:1))
                    ]
    
    required init?(coder aDecoder: NSCoder) {
        
        actionMenu = KCFloatingActionButton()
        
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
     
        
        //TODO If the collectionView fits allright in screen, no need to enable the scroll
        collectionView.isScrollEnabled = true
     
        //Action Manu Setup:

//       setupActionButtonMenu()
        
        super.awakeFromNib()
    }

    
//    public func copyCellHeaderView() -> (RotatedView) {
//        
//        let copiedCell : CropLifeCycleTableViewCell = self.copyView() as! CropLifeCycleTableViewCell
//        let progressNumber = CGFloat(integerLiteral: 54)
//        copiedCell.ringProgressBar.setValue(progressNumber, animateWithDuration: 3.0)
//        
//        return copiedCell.foregroundView
//        
//        
//    }
    
    
    func setCollectionViewDataSourceDelegate <D: UICollectionViewDataSource & UICollectionViewDelegate>
        (dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }
    
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    
    
    public func setCellWith(crop: Crop) {
        
        self.crop = crop
        self.cropName.text = crop.name
        
        if let datePlanted = crop.getDayPlanted() {
            
            self.datePlanted.text = "Date Planted: " + datePlanted.inCellDateFormat()
            self.harvestDate.text = "Harvest Date: " + (crop.getEstimatedHarvestDate()!.inCellDateFormat())
            let progressNumber = CGFloat(integerLiteral: crop.getEstimatedDaysLeftToHarvest()!)
            self.ringProgressBar.setValue(progressNumber, animateWithDuration: 3.0)
            
        } else {
            
            self.ringProgressBar.setValue(45, animateWithDuration: 3.0)
        }
       
        setupActionButtonMenu()
    }
    
    public func copyForegroundViewOfCellIntoContainer() {
        
        //Get the colletionView and copy the foreground into the "header" of the collection
        self.containerView.subviews.forEach({ (view) in
            
            if (view is UICollectionView) {
                
                let referencedCollectionView = (view as! UICollectionView)
                let copiedView : UIView = self.foregroundView.copyView()
                
                copiedView.subviews.forEach({ (view) in
                    if (view is MBCircularProgressBarView) {
                        //TODO Uncomment when using real datasource!
                        //  let progressNumber = CGFloat(integerLiteral: myPlantedCrops[indexPath.row].getEstimatedDaysLeftToHarvest())
                        
                        //                            (view as!  MBCircularProgressBarView).setValue(progressNumber, animateWithDuration: 3.0)
                    }
                })
                
                
                self.containerView.addSubview(copiedView)
                
                copiedView.snp.makeConstraints({ (make) in
                    make.top.equalToSuperview()
                    make.left.equalToSuperview()
                    make.right.equalToSuperview()
                    make.bottom.equalTo(referencedCollectionView.snp.top)
                })
                
                copiedView.layer.borderColor = self.layer.borderColor
                copiedView.layer.borderWidth = self.layer.borderWidth
                copiedView.layer.cornerRadius = self.layer.cornerRadius
            }
        })
    }
    
    private func setupActionButtonMenu () {
        
        actionMenu.openAnimationType = KCFABOpenAnimationType.pop
        actionMenu.openingAnimationDirection = KCFABOpeningAnimationDirection.Vertical
        
        self.containerView.addSubview(actionMenu)

        guard let cropie = self.crop else { return  }
        
        actionMenu.addItem("Weed", icon: UIImage(named: "icon_weeding")) { (item) in
            
            self.showConfirmationScreenFor(action: .WeedAction, crop: cropie)
        }
        
        actionMenu.addItem("Water", icon: UIImage(named:"icon_watering")) { (item) in
            
           self.showConfirmationScreenFor(action: .WaterAction, crop: cropie)
        }
        
        actionMenu.addItem("Fertilize", icon: UIImage(named:"icon_fertilize")) { (item) in
            
           self.showConfirmationScreenFor(action: .FertilizeAction, crop: cropie)
        }
        
        if (cropie.isReadyForHarvest()) {
            
            actionMenu.addItem("Harvest", icon: UIImage(named:"icon_harvest")) { (item) in
                
                self.showConfirmationScreenFor(action: .HarvestAction, crop: cropie)
                
            }
        
            //TODO: Ask the crop if it can be finished to show this option!
            actionMenu.addItem("Finish", icon: UIImage(named:"icon_harvest")) { (item) in
                
                self.showConfirmationScreenFor(action: .FinishAction, crop: cropie)
            }
        
        }
    }
    
    private func showConfirmationScreenFor(action: GrowingActions, crop: Crop) {
        
        let appearance = SCLAlertView.SCLAppearance(kWindowWidth: screenWidth * 0.9,
                                                    kWindowHeight: screenHeight * 0.9,
                                                    showCloseButton: true)
        
        let alert = ActionMenuAlertView(appearance: appearance,
                                        crop: crop,
                                        action: action,
                                        and: .Row)
        
        
        let actionString = alert.stringAction(action: action)
        
        
        //TODO Improve this for showing different colors and images for the different actions
        
        
        alert.showCustom(actionString!,
                            subTitle: crop.name!,
                               color: UIColor.green,
                                icon: UIImage(named:"icon_weeding")!)

        
    }
    
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //If the touch is outside the button let the tableView handle the event
        
        let touch = touches.first
        
        let point = touch?.location(in: self.containerView)
    
        if (!actionMenu.frame.contains(point!)) { super.touchesBegan(touches, with: event) }
    }
    
}