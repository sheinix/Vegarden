//
//  MyGardenViewController.swift
//  
//
//  Created by Sarah Cleland on 28/11/16.
//
//

import UIKit

class MyGardenViewController: UITableViewController {

    let totalPlantedCrops = String(describing: GardenManager.shared.myPlantedCrops()?.count)
    let totalPaddocks = String(describing: GardenManager.shared.getMyGarden().paddocks?.count)
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell?
        
        if (indexPath.section == 0) {
            cell = (tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MyGardenOverviewCellIdentifier, for: indexPath) as! MyGardenOverviewTableViewCell)
        
        } else {
            cell = (tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MyGardenDetailCellIdentifier, for: indexPath) as! MyGardenDetailTableViewCell)
        }
        

        return cell!
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if (section == 0){
            return "Overview  |  Planted Crops : " + totalPlantedCrops
        }
        
        return "My Garden | Patchs : " + totalPaddocks
        
        
    }
    
    
    /*
     Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
