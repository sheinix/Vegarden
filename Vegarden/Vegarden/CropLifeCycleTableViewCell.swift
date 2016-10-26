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
import CircleMenu

class CropLifeCycleTableViewCell: FoldingCell {

    @IBOutlet weak var ringProgressBar: MBCircularProgressBarView!
    @IBOutlet weak var cropName: UILabel!
    @IBOutlet weak var datePlanted: UILabel!
    @IBOutlet weak var harvestDate: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var actionMenu: CircleMenu!
    
    let items: [(icon: String, color: UIColor)] = [
                    ("icon_weeding", UIColor(red:0.19, green:0.57, blue:1, alpha:1)),
                    ("icon_fertilize", UIColor(red:0.22, green:0.74, blue:0, alpha:1)),
                    ("icon_water", UIColor(red:0.96, green:0.23, blue:0.21, alpha:1)),
                    ("icon_harvest", UIColor(red:0.51, green:0.15, blue:1, alpha:1))
                    ]

    
//    @IBOutlet weak var accesoryView: UIView!
    
    //var lifeCycleDetailView : LifeCycleDetailiView
   // var crop : Crop
    
//    var progressNumber : CGFloat {
//        
//        get {
//            return CGFloat(integerLiteral: crop.getEstimatedDaysLeftToHarvest())
//            }
//    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
      //  crop = nil
        
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
        actionMenu.clipsToBounds = false
        actionMenu.layer.masksToBounds = false
        actionMenu.superview?.clipsToBounds = false
        //actionMenu.superview?.layer.masksToBounds = false
        actionMenu.distance = 90
        actionMenu.duration = 0.3
        actionMenu.buttonsCount = 4
        actionMenu.backgroundColor = UIColor.lightGray
        actionMenu.delegate = self
        actionMenu.layer.cornerRadius = actionMenu.frame.size.width / 2.0
    
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
        
        //self.crop = crop
        self.cropName.text = crop.name
        self.datePlanted.text = "Date Planted: " + (crop.getDayPlanted()?.inCellDateFormat())!
        self.harvestDate.text = "Harvest Date: " + (crop.getEstimatedHarvestDate().inCellDateFormat())
        
        let progressNumber = CGFloat(integerLiteral: crop.getEstimatedDaysLeftToHarvest())
        
        self.ringProgressBar.setValue(progressNumber, animateWithDuration: 3.0)
        
       
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
}

// MARK: <CircleMenuDelegate>

extension CropLifeCycleTableViewCell : CircleMenuDelegate {
    
    func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        
        button.backgroundColor = items[atIndex].color
        
        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
        
        // set highlited image
        let highlightedImage  = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
    }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
      
        print("button did selected: \(atIndex)")
    
    }
    
}
