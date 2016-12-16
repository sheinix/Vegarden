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
    @IBOutlet weak var collectionView: UICollectionView! //was private
   
    var actionMenu : KCFloatingActionButton
    var crop : Crop?
   
    var lifeCycleDict : [String : [Any]] = [lifeCyclceSates.Seed: [],
                                            lifeCyclceSates.Growig: [],
                                            lifeCyclceSates.Harvesting: []]
//                                            lifeCyclceSates.Finish: []]
    
    required init?(coder aDecoder: NSCoder) {
        
        actionMenu = KCFloatingActionButton()
        actionMenu.buttonColor = Colors.mainColorUI
        
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        
        foregroundView.layer.cornerRadius = UINumbericConstants.commonCornerRadius
        foregroundView.layer.masksToBounds = true
        foregroundView.layer.borderWidth = 1
        
        foregroundView.layer.borderColor = Colors.mainColorUI.cgColor
        containerView.layer.cornerRadius = UINumbericConstants.commonCornerRadius
        
        
        collectionView.isScrollEnabled = true
        collectionView.layer.borderColor = Colors.mainColorUI.cgColor
        collectionView.layer.borderWidth = 1
        collectionView.layer.cornerRadius = UINumbericConstants.commonCornerRadius
        collectionView.applyLightShadow()
        
        super.awakeFromNib()
    }

    
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
        
        if let datePlanted = crop.dayPlanted {
        
            self.datePlanted.text = "Date Planted: " + datePlanted.inCellDateFormat()
            self.harvestDate.text = "Harvest Date: " + (crop.estimatedHarvestDate.inCellDateFormat())
            
            self.ringProgressBar.value = CGFloat((crop.percentageCompleted*100) > 0 ? (crop.percentageCompleted*100) : 1)
        }


        if !(actionMenu.superview != nil) {
            setupActionButtonMenu()
        }
        
    }
    
    public func reloadNotes() ->  [String : [Any]]? {
        
        guard let crop = self.crop else { return nil }
        
        self.lifeCycleDict.updateValue([], forKey: lifeCyclceSates.Growig)
       // self.lifeCycleDict.updateValue([], forKey: lifeCyclceSates.Harvesting)
        
        self.setGrowingNotes(crop: crop)
        //self.setHarvestingStates(crop: crop)
        
        return self.lifeCycleDict
    }
    
    public func setupNotesForDictionaryWith(crop: Crop) ->  [String : [Any]] {
       
        setPlantedStates(crop: crop)
        setGrowingNotes(crop: crop)
        setHarvestingStates(crop: crop)
       
        return self.lifeCycleDict
    }
    
    private func setGrowingNotes(crop: Crop) {
        
        let growingNotes : [RowLifeState] = crop.actionsMade
        
//        crop.row?.allObjects.forEach({ (row) in
//            
//            if let states = (row as! Row).lifeCycleState?.allObjects as! [RowLifeState]? {
//                
//                states.forEach({ (state) in
//                    
//                    if !growingNotes.contains(where: { (rowLifeState) -> Bool in
//                        
//                        return (rowLifeState.when == state.when &&
//                              //  rowLifeState.self == state.self &&
//                               // rowLifeState.lifeStateId == state.lifeStateId &&
//                                rowLifeState.notes == state.notes)
//                    }) {
//                
//                        growingNotes.append(state)
//                    }
//
//                })
//                
//                
//            }
//        })

        if (growingNotes.count > 0) {
            
            self.lifeCycleDict.updateValue(growingNotes.uniqueElements, forKey: lifeCyclceSates.Growig)
        }
    }
    
    private func setPlantedStates(crop: Crop) {
        
        if let plantState = crop.getStatesOf(type: (crop.isFromSeed ? .Seed : .Seedling)) {
            
            self.lifeCycleDict.updateValue(plantState, forKey: lifeCyclceSates.Seed)
        }
    }
    
    private func setHarvestingStates(crop: Crop) {
       
        if let harvestingStates = crop.getStatesOf(type: .Harvested) {
            
            self.lifeCycleDict.updateValue(harvestingStates, forKey: lifeCyclceSates.Harvesting)
        }

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
        
        actionMenu.addItem("Remove", icon: UIImage(named:"icon_fertilize")) { (item) in
            
           item.circleShadowColor = Colors.removeColor
            self.showConfirmationScreenFor(action: .UnplantAction, crop: cropie)
        }

        actionMenu.addItem("Weed", icon: UIImage(named: "icon_weeding")) { (item) in
           
            item.circleShadowColor = Colors.weedColor
            self.showConfirmationScreenFor(action: .WeedAction, crop: cropie)
        }
        
        actionMenu.addItem("Water", icon: UIImage(named:"icon_watering")) { (item) in
            
            item.circleShadowColor = Colors.waterColor
            
           self.showConfirmationScreenFor(action: .WaterAction, crop: cropie)
        }
        
        actionMenu.addItem("Fertilize", icon: UIImage(named:"icon_fertilize")) { (item) in
           
            item.circleShadowColor = Colors.fertilizeColor
           
           self.showConfirmationScreenFor(action: .FertilizeAction, crop: cropie)
        }
        
        if (cropie.isReadyForHarvest) {
        
            actionMenu.addItem("Harvest", icon: UIImage(named:"icon_harvest")) { (item) in
                
                item.circleShadowColor = Colors.harvestColor
                
                self.showConfirmationScreenFor(action: .HarvestAction, crop: cropie)
                
            }
        }
        
        if (cropie.hasBeenHarvested) {
            
                actionMenu.addItem("Finish", icon: UIImage(named:"icon_harvest")) { (item) in
                
                item.circleShadowColor = Colors.finishHarvestColor

                self.showConfirmationScreenFor(action: .FinishAction, crop: cropie)
            }
        
        }
        
    }
    
    private func showConfirmationScreenFor(action: GrowingActions, crop: Crop) {
        
        let appearance = Appereance().appereanceForAlert(frame: self.bounds,
                                                         color: colorFor(growingAction: action).0!,needsTitle: false)

        let alert = ActionMenuAlertView(appearance: appearance,
                                              crop: crop,
                                            action: action,
                                        isPlanting: false,
                                               and: .Row)
        
        
       // let actionString = alert.stringAction(action: action)
        
        let _ = alert.showInfo("",
                               subTitle: "",
                               closeButtonTitle: "Close",
                               duration: 0,
                               colorStyle: colorFor(growingAction: action).1!,
                               colorTextButton: 0xFFFFFF,
                               animationStyle: .topToBottom)
        
    }
    
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //If the touch is outside the button let the tableView handle the event
        
        let touch = touches.first
        
        let point = touch?.location(in: self.containerView)
    
        if (!actionMenu.frame.contains(point!)) { super.touchesBegan(touches, with: event) }
    }
    
}
