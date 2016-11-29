//
//  MyGardenViewController.swift
//  
//
//  Created by Sarah Cleland on 28/11/16.
//
//

import UIKit

class MyGardenViewController: UITableViewController {

    let totalPlantedCrops : Int = (GardenManager.shared.myPlantedCrops()?.count)!
    let totalPaddocks : Int = (GardenManager.shared.getMyGarden().paddocks?.count)!
    let patchs : [Paddock] = (GardenManager.shared.getMyGarden().paddocks?.allObjects as! [Paddock])
    var rowsHeight : CGFloat?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "My Garden"
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.rowsHeight = (CGFloat(totalPlantedCrops) * CGFloat(cropRowHeight)) + 10
        self.tableView.estimatedRowHeight = self.rowsHeight!
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.isScrollEnabled = false
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
            if let collection = (cell as! MyGardenDetailTableViewCell).myGardenCollectionView {
                
                collection.delegate = self
                collection.dataSource = self
                collection.reloadData()
            }
            
        }
        

        return cell!
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if (section == 0){
            
            return "Overview  |  Planted Crops : " + String(totalPlantedCrops)
        }
        
        return "My Garden | Patchs : " + String(totalPaddocks)
 
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return (indexPath.section == 0 ? self.rowsHeight! : screenHeight - self.rowsHeight!)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0 ? self.rowsHeight! : screenHeight - self.rowsHeight!)
    }
    
 

}

extension MyGardenViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return patchs.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.MyGardenDeteailCollectionCellIdentifier, for: indexPath) as! MyGardenDetailCollectionViewCell)
        
        cell.patch = patchs[indexPath.row]
        
        return cell
        
    }
    
}
extension MyGardenViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (Int(self.view.bounds.width) / patchs.count) - 10
        
        return CGSize(width: width, height: 300)
        
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //
    //        return CGFloat(integerLiteral: 10)
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //
    //        return CGFloat(integerLiteral: 10)
    //    }
    
    
    
}
