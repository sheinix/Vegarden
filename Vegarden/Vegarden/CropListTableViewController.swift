//
//  CropListTableViewController.swift
//  Vegarden
//
//  Created by Sarah Cleland on 17/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class CropListTableViewController: UITableViewController {

    var allCrops = GardenManager.shared.allCrops()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.register(CropListTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.CropListTableViewCellIdentify)
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
        
        return allCrops.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.CropListTableViewCellIdentify, for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = allCrops[indexPath.row].caption
        
        return cell
    }
   

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return false
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let layout = HelperManager.getCropDetailCollectionViewFlowLayoutIn(navigationController: self.navigationController!)
        let pageDetailViewController =
            CropDetailCollectionViewController(collectionViewLayout: layout, currentIndexPath:indexPath as NSIndexPath)
        
        pageDetailViewController.cropList = allCrops
        navigationController?.title = "Select from the list"
        navigationController!.pushViewController(pageDetailViewController, animated: true)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
