//
//  MyGardenViewController.swift
//  
//
//  Created by Sarah Cleland on 28/11/16.
//
//

import UIKit
import SCLAlertView

class MyGardenViewController: UITableViewController, TableHeaderAddButtonProtocol {

    let totalPlantedCrops : Int = (GardenManager.shared.myPlantedCrops()?.count)!
    let totalPaddocks : Int = (GardenManager.shared.getMyGarden().paddocks?.count)!
    let patchs : [Paddock] = (GardenManager.shared.getMyGarden().paddocks?.allObjects as! [Paddock])
    var rowsHeight : CGFloat?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.rowsHeight = (CGFloat(totalPlantedCrops) * CGFloat(cropRowHeight)) + 10
        self.tableView.estimatedRowHeight = self.rowsHeight!
        self.tableView.tableHeaderView = MyGardenHeaderView.loadFromNibNamed(nibNamed: "MyGardenHeaderView")
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
               // collection.reloadData()
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = MyGardenTableSectionHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 100))
        
        let title = (section == 0 ? "Overview  |  Planted Crops : " + String(totalPlantedCrops) : "My Garden | Patchs : " + String(totalPaddocks))
        
        header.titleLabel.text = title
        header.addPatchButton.isHidden = (section == 0)
        header.delegate = self
        return header
        
    }
    
    func didPushAddButton(button: UIButton) {
        
        showAddEditPatch(patch: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return (indexPath.section == 0 ? self.rowsHeight! : screenHeight - self.rowsHeight!)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0 ? self.rowsHeight! : screenHeight - self.rowsHeight!)
    }
    
    fileprivate func showAddEditPatch(patch: Paddock?) {
        
        let appearance = SCLAlertView.SCLAppearance(kWindowWidth: screenWidth * 0.9,
                                                    kWindowHeight: screenHeight * 0.9,
                                                    showCloseButton: true,
                                                    showCircularIcon: false)
        
        let alert = PatchAddEditViewController(appearance: appearance, patch: patch)
        
        
        let _ = alert.showEdit((patch != nil ? (patch?.name!)! : "Add New Patch"),
                               subTitle: "")
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
        cell.delegate = self
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let patch = (collectionView.cellForItem(at: indexPath) as! MyGardenDetailCollectionViewCell).patch else { return }
            
        showAddEditPatch(patch: patch)
      
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in

            self.tableView.tableHeaderView? = MyGardenHeaderView.loadFromNibNamed(nibNamed: "MyGardenHeaderView")!
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
        
            
        })
        
        super.viewWillTransition(to: size, with: coordinator)
    }
    
}
extension MyGardenViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (Int(self.view.bounds.width) / 3) - 10
        
        return CGSize(width: width, height: 255)
        
    }
}
extension MyGardenViewController : MyGardenDetailCollectionViewCellProtocol {
    
    func willDelete(patch: Paddock!) {
       
        
        if (patch.isEmpty) {
        
                self.showAlertView(title:  "Delete " + patch.name!,
                         message: "Are you sure want to delete the Patch? ",
                           style: .alert,
                    confirmBlock: { GardenManager.shared.removePatch(paddock: patch) },
                     cancelBlock:  { })
        
        } else {
            
            self.showSimpleAlertViewWith(title: "Delete " + patch.name!,
                                         message: "The Patch has planted Rows. Remove Crops from Patch before deleting it ",
                                         style: .alert)
            
        }
    }
}
