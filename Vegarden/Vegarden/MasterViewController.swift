//
//  MasterViewController.swift
//  tst
//
//  Created by Juan Nuvreni on 10/3/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
//    var detailViewController: DetailViewController? = nil
    var objects = [MainViews.MyCropsView, MainViews.LifeCycleView, MainViews.MyGardenView, MainViews.AboutView]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let split = self.splitViewController {
//            let controllers = split.viewControllers
//            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//   
//        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
//        controller.viewControllerInside = insideVC
//        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
//        controller.navigationItem.leftItemsSupplementBackButton = true
//        
//    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let object = objects[indexPath.row] 
        cell.textLabel!.text = object.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var segueId : String!
        
        switch objects[indexPath.row] {
            
        case MainViews.MyCropsView:
            segueId = SegueIdentifiers.showMyCropsView
            
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
}
