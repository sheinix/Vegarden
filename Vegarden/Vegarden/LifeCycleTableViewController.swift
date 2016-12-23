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
    
    var lifeStatesArray : [[String : [Any]]] = []
    
    let lifeCycle = [lifeCyclceSates.Planted,
                     lifeCyclceSates.Growig,
                     lifeCyclceSates.Harvesting]
        
    
    //TableView sources:
    let kCloseCellHeight: CGFloat = 150
    let kOpenCellHeight: CGFloat = 600
    
    var myPlantedCrops = GardenManager.shared.myPlantedCrops()
    
    var cellHeights = [CGFloat]()
   
    fileprivate struct C {
        struct CellHeight {
            static let close: CGFloat = 150 // equal or greater foregroundView height
            static let open: CGFloat = 600 // equal or greater containerView height
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO make it show in the title!
        self.title =  "Crops Life Cycle"
        self.navigationController?.navigationBar.tintColor = UIColor(cgColor: Colors.mainColor)
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: Fonts.mainFont]
        
        if let myPlantedCrops = self.myPlantedCrops {
            
            cellHeights = (0..<Int((myPlantedCrops.count))).map { _ in C.CellHeight.close }
        }
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        
        // A little trick for removing the cell separators
        //self.tableView.tableFooterView = UIView.new
        
        
        
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(actionMade),
                                                name: NSNotification.Name(rawValue: NotificationIds.NotiKeyGrowingActionMade),
                                                object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(cropUnplanted),
                                               name: NSNotification.Name(rawValue: NotificationIds.NotiKeyCropUnPlanted),
                                               object: nil)

    }

    override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()

    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func cropUnplanted(notification: NSNotification) {
        
        let cropRow = notification.userInfo?["notiObj"] as! NotificationIds.cropRow
        
        if (cropRow.crop?.isPlanted)! { //Crop has been removed from some rows!
            
            if ((cropRow.crop?.row?.filter { ($0 as! Row).hasActionsDone }.count)! > 0) {
                    reloadCellNotes(crop: cropRow.crop!)
            }
            
            let title = (cropRow.crop?.name)! + (cropRow.isFinished ? " Finished!" : " Unplanted!")
            self.view.showConfirmViewWith(title: title, frame: nil, afterAction: nil)
            
        } else { //Crop has been deleted!

            if let idx = self.myPlantedCrops?.index(where: { $0 === cropRow.crop }) {
                
                self.myPlantedCrops?.remove(at: idx)
                cellHeights = (0..<Int((myPlantedCrops?.count)!)).map { _ in C.CellHeight.close }
                self.tableView.deleteRows(at: [IndexPath(row: idx, section:0)], with: .none)
                
                self.lifeStatesArray.remove(at: idx)
                
                self.tableView.reloadData()
                
            }
            let title = (cropRow.isFinished ? " Crop Finished!" : "Crop Unplanted!")
            self.view.showConfirmViewWith(title: title, frame: nil, afterAction: nil)
            
            //self.myPlantedCrops = self.myPlantedCrops?.filter { $0.isPlanted }

        }
        
    }
    
    @objc func actionMade(notification: NSNotification) {
        
        let action : ActionMadeDTO = notification.userInfo?["action"] as! ActionMadeDTO
        
        //First reload the row which have the crop. Use === to compare Instance!!
        //TODO Test this with same crop planted two times...
        
        reloadCellNotes(crop: action.crop)
        self.view.showConfirmViewWith(title: action.screenTitle, frame: nil, afterAction: nil)
        
    }
    
    private func reloadCellNotes(crop: Crop) {
        
        //Get the tableCell of the Crop:
        let idx = self.myPlantedCrops?.index(where: { $0 === crop })
        let idxPath = IndexPath(row: idx!, section: 0)
        let cell = (self.tableView.cellForRow(at: idxPath) as! CropLifeCycleTableViewCell)
        
        //Get the idx of cell dict:
        self.lifeStatesArray.remove(at: idx!)
        self.lifeStatesArray.insert(cell.reloadNotes()!, at: idx!)
        
        cell.collectionView.reloadItems(at: [IndexPath(row: 1, section: 0)])//,IndexPath(row:2, section:0)])

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
        
        if (cell.crop == nil || cell.crop !== crop) {
            
            cell.setCellWith(crop: crop)
            
            //Setup the dict in the cell and add it to the array!
            let dict = cell.setupNotesForDictionaryWith(crop: crop)
            self.lifeStatesArray.append(dict)
        } 
        
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
         
            //TODO:
            //This line here, is copying the heder cell and triggering the nslayoutunsatisfy constraints:
           // cell.copyForegroundViewOfCellIntoContainer()
            
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
