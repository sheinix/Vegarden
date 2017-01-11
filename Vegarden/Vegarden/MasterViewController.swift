//
//  MasterViewController.swift
//  tst
//
//  Created by Juan Nuvreni on 10/3/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    let objects = [MainViews.MyGardenView,
                   MainViews.LifeCycleView,
                   MainViews.MyCropsView,
                   MainViews.DataBaseView,
                   MainViews.AboutView]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.isScrollEnabled = false
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = true
        
        self.tableView.backgroundColor = UIColor.white//UIColor(red: 213, green: 240, blue: 226, alpha: 0.5)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.sideTabCellIdentifier, for: indexPath) as! SideBarMenuTableViewCell
        
        var img : UIImage
        var title : String
        
        switch objects[indexPath.row] {
          
            case MainViews.MyCropsView:
                img = UIImage(named: "crops")!
                title = MainViews.MyCropsView
            case MainViews.DataBaseView:
                img = UIImage(named: "database")!
                title = MainViews.DataBaseView
            case MainViews.LifeCycleView:
                img = UIImage(named: "lifecycle")!
                title = MainViews.LifeCycleView
            case MainViews.MyGardenView:
                img = UIImage(named: "garden")!
                title = MainViews.MyGardenView
            case MainViews.AboutView:
                img = UIImage(named: "info")!
                title = MainViews.AboutView
        default:
                img = UIImage(named: "info")!
                title = MainViews.AboutView
        }
        
        
        (cell as SideBarMenuTableViewCell).tabImgView.image = img
        (cell as SideBarMenuTableViewCell).titleLabel.text = title
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        let cell = tableView.cellForRow(at: indexPath)
//        let imgView = (cell as! SideBarMenuTableViewCell).tabImgView
//        
//        return (imgView?.frame.height)!
//    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var segueId : String!
        
        switch objects[indexPath.row] {
            
        case MainViews.MyCropsView:
            segueId = SegueIdentifiers.showMyCropsView
        
        case MainViews.DataBaseView:
            segueId = SegueIdentifiers.showDataBaseView
            
        case MainViews.LifeCycleView:
            segueId = SegueIdentifiers.showLifeCycleView
            
        case MainViews.MyGardenView:
            segueId = SegueIdentifiers.showMyGardenView
            
        case MainViews.AboutView:
            segueId = SegueIdentifiers.showAboutView
            
        default:
            segueId = SegueIdentifiers.showAboutView
        }
        
        self.performSegue(withIdentifier: segueId, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier ==  SegueIdentifiers.showMyCropsView) {
            
            let navController = (segue.destination as! ZoomInNavigationController)
            
            if let myCrops = navController.viewControllers.first {
                
                (myCrops as! MyCropsCollectionViewController).isDataBase = false
            }
            
        } else if (segue.identifier ==  SegueIdentifiers.showDataBaseView) {
            
            let navController = (segue.destination as! ZoomInNavigationController)
            
            if let myCrops = navController.viewControllers.first {
                
                (myCrops as! MyCropsCollectionViewController).isDataBase = true
            }
        }
    }
}
