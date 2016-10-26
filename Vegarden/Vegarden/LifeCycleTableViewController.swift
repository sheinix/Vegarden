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

class LifeCycleTableViewController: UITableViewController {

    //CollectionView sources:
    let sectionInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    let lifeCycle = [lifeCyclceSates.Seed,
                     lifeCyclceSates.Growig,
                     lifeCyclceSates.Harvesting,
                     lifeCyclceSates.Finish]

    
    
    //TableView sources:
    let kCloseCellHeight: CGFloat = 150
    let kOpenCellHeight: CGFloat = 460
    
    var myPlantedCrops = [MainViews.LifeCycleView, MainViews.MyGardenView, MainViews.AboutView] //GardenManager.shared.myPlantedCrops()
    
    var cellHeights = [CGFloat]()
   
    fileprivate struct C {
        struct CellHeight {
            static let close: CGFloat = 150 // equal or greater foregroundView height
            static let open: CGFloat = 460 // equal or greater containerView height
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cellHeights = (0..<Int((myPlantedCrops.count))).map { _ in C.CellHeight.close }
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (myPlantedCrops.count)
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
        
        cell.cropName.text = myPlantedCrops[indexPath.row]
        cell.datePlanted.text = String(describing: Date())
        cell.harvestDate.text = "Harvest Date: Septembre 10th 2017"
        cell.ringProgressBar.setValue(25, animateWithDuration: 1.0)
        
//        cell.lifeCycleDetailView = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LifeCycleDetailiView") as! LifeCycleDetailiView
//        
//        self.addChildViewController(cell.lifeCycleDetailView)
//        cell.lifeCycleDetailView.didMove(toParentViewController: self)
//        cell.containerView.addSubview(cell.lifeCycleDetailView.view)
//        
//        cell.lifeCycleDetailView.view.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().inset(cell.frame.height).multipliedBy(0.80)
//            make.bottom.equalToSuperview().inset(5)
//            make.left.equalToSuperview().inset(5)
//            make.right.equalToSuperview().inset(5)
//        }

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
         
            
            
//            cell.lifeCycleDetailView.collectionView?.reloadData()
            
            cellHeights[(indexPath as NSIndexPath).row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
                
        } else {// close cell
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

    private func createCellHeightsArray() {
        
        let limit = self.myPlantedCrops.count
        
            for _ in 0...limit  {
                cellHeights.append(kCloseCellHeight)
            }
        }
}
