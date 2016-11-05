//
//  LifeCycleTableViewController.swift
//  Vegarden
//
//  Created by Sarah Cleland on 24/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import SnapKit
import KCFloatingActionButton

class LifeCycleTableViewController: UITableViewController {

    //CollectionView sources:
    let sectionInsets = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
    
    let lifeCycle = [lifeCyclceSates.Seed,
                     lifeCyclceSates.Growig,
                     lifeCyclceSates.Harvesting,
                     lifeCyclceSates.Finish]

    var lifeCycleDict : [String : [Any]] = [lifeCyclceSates.Seed: [],
                                            lifeCyclceSates.Growig: [],
                                            lifeCyclceSates.Harvesting: [],
                                            lifeCyclceSates.Finish: []]
    
    
    //TableView sources:
    let kCloseCellHeight: CGFloat = 150
    let kOpenCellHeight: CGFloat = 460
    
    var myPlantedCrops = GardenManager.shared.myPlantedCrops()
    
    var cellHeights = [CGFloat]()
   
    fileprivate struct C {
        struct CellHeight {
            static let close: CGFloat = 150 // equal or greater foregroundView height
            static let open: CGFloat = 460 // equal or greater containerView height
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let myPlantedCrops = self.myPlantedCrops {
            
            cellHeights = (0..<Int((myPlantedCrops.count))).map { _ in C.CellHeight.close }

        }
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
    }

    override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count = myPlantedCrops?.count else { return 0  }
        
        return count
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard case let cell as FoldingCell = cell else {
            return
        }
        
        cell.backgroundColor = UIColor.clear
        
        if cellHeights[(indexPath as NSIndexPath).row] == kCloseCellHeight {
            cell.selectedAnimation(false, animated: false, completion:nil)
        } else {
            cell.selectedAnimation(true, animated: false, completion: nil)
        }
        
        //guard let newCell = cell as? CropLifeCycleTableViewCell else { return }
        
        (cell as! CropLifeCycleTableViewCell).setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = (tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.lifeCycleTableViewCellIdentifier, for: indexPath) as! CropLifeCycleTableViewCell)
        
        let crop = myPlantedCrops![indexPath.row]
        
        cell.setCellWith(crop: crop)
        
        setupNotes(crop: crop)
        
        return cell
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return cellHeights[(indexPath as NSIndexPath).row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CropLifeCycleTableViewCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        if cellHeights[(indexPath as NSIndexPath).row] == kCloseCellHeight { // open cell
         
            cell.copyForegroundViewOfCellIntoContainer()
            
            cellHeights[(indexPath as NSIndexPath).row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
            
        } else {// close cell
            
            //Remove the rotatedview copied
            cell.containerView.subviews.forEach({ (view) in
                if (view is RotatedView) {
                    view.removeFromSuperview()
                }
            })
            
            //When tableView handles close of cell, but Menu is open:
            if (!cell.actionMenu.closed) { cell.actionMenu.close()}
            
            
            cellHeights[(indexPath as NSIndexPath).row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            }, completion: nil)
        
        
    }

//    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        
//        (cell as! CropLifeCycleTableViewCell).lifeCycleDetailView.removeFromParentViewController()
//        
//    }
//MARK: - Helper methods
    
    private func setupNotes(crop: Crop) {
       
        //Get the notes for the Growing Actions made to the rows:
        
        var growingNotes : [RowLifeState] = []
        
        crop.row?.allObjects.forEach({ (row) in
            
            if let states = (row as! Row).lifeCycleState?.allObjects as! [RowLifeState]? {
                
                growingNotes.append(contentsOf: states)
            }
        })

        //Get the planted state :
        
        if let plantState = crop.getStatesOf(type: (crop.isFromSeed() ? .Seed : .Seedling)) {
        
            lifeCycleDict.updateValue(plantState, forKey: lifeCyclceSates.Seed)
        }
        
        //Get the harvesting States:
        
        if let harvestingStates = crop.getStatesOf(type: .Harvested) {
            
            lifeCycleDict.updateValue(harvestingStates, forKey: lifeCyclceSates.Harvesting)
        }
        
        if (growingNotes.count > 0) {
            
            lifeCycleDict.updateValue(growingNotes, forKey: lifeCyclceSates.Growig)
        }
        
    }
    
    
    private func copyForegroundViewOfCellIntoContainer(cell: CropLifeCycleTableViewCell) {
        
        //Get the colletionView and copy the foreground into the "header" of the collection
        cell.containerView.subviews.forEach({ (view) in
            
            if (view is UICollectionView) {
                
                let referencedCollectionView = (view as! UICollectionView)
                let copiedView : UIView = cell.foregroundView.copyView()
                
                copiedView.subviews.forEach({ (view) in
                    if (view is MBCircularProgressBarView) {
                        //TODO Uncomment when using real datasource!
                        //  let progressNumber = CGFloat(integerLiteral: myPlantedCrops[indexPath.row].getEstimatedDaysLeftToHarvest())
                        
                        //                            (view as!  MBCircularProgressBarView).setValue(progressNumber, animateWithDuration: 3.0)
                    }
                })
                
                
                cell.containerView.addSubview(copiedView)
                
                copiedView.snp.makeConstraints({ (make) in
                    make.top.equalToSuperview()
                    make.left.equalToSuperview()
                    make.right.equalToSuperview()
                    make.bottom.equalTo(referencedCollectionView.snp.top)
                })
                
                copiedView.layer.borderColor = cell.layer.borderColor
                copiedView.layer.borderWidth = cell.layer.borderWidth
                copiedView.layer.cornerRadius = cell.layer.cornerRadius
            }
        })
    }
}
