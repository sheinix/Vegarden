//
//  PatchAddEditViewController.swift
//  Vegarden
//
//  Created by Sarah Cleland on 30/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SCLAlertView
import SnapKit

class PatchAddEditViewController: SCLAlertView {

    var patch : Paddock?
    var patchInfoTableView: UITableView = UITableView(frame: screenBounds, style: UITableViewStyle.plain)
    var isAddingNewPatch : Bool!
    
    var patchUpdateInfo = PatchInfo()
    
    
    required init(appearance: SCLAppearance, patch: Paddock?) {
        
        super.init(appearance: appearance)
        
        self.patch = patch
        self.isAddingNewPatch = !(patch != nil)
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }

    override func viewDidLoad() {
        
        setupViews()
    
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setupViews () {
        
        self.patchInfoTableView.delegate = self
        self.patchInfoTableView.dataSource = self
        self.patchInfoTableView.register(PatchEditionTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.PatchEditionCellIdentifier)
        
        self.customSubview = self.patchInfoTableView
        self.customSubview?.clipsToBounds = true
        self.customSubview?.layer.masksToBounds = true
        
        self.addButton("Confirm") {
            
            self.confirmButtonPressed()
        }
        
    }
    
    fileprivate func confirmButtonPressed() {
        
        if (self.isAddingNewPatch!) {
            
            if (self.patchUpdateInfo.isReadyForCreation) {
                
                GardenManager.shared.addPaddock(paddockInfo: self.patchUpdateInfo)
                
            } else {
                
                self.showSimpleAlertViewWith(title: "Hold On!",
                                         message: "Some fields are incomplete!",
                                         style: .alert)
            }
            
            
        } else if (self.patchUpdateInfo.hasSomeDataToUpdate) {
            
                GardenManager.shared.update(paddock: self.patch, with: self.patchUpdateInfo)
        
        } else {
            
            self.showSimpleAlertViewWith(title: "Information",
                                         message: "No changes were made!",
                                         style: .alert)
        }
    }
    
}
extension PatchAddEditViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.PatchEditionCellIdentifier) as! PatchEditionTableViewCell)
        
        //TODO Change later, not good design to ask for the cell passing the row...
        cell.setTxtViewWith(patch: self.patch, forCellAt: indexPath.row)
        cell.txtField.delegate = self
        cell.txtField.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        return (self.isAddingNewPatch! ? "New Patch" : self.patch?.name!)
        
    }
}
extension PatchAddEditViewController : UITextFieldDelegate {
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        //validate code
//        
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag {
            
            case patchEditionRows.PatchName.rawValue:
                self.patchUpdateInfo.name = textField.text!
            
            case patchEditionRows.PatchLocation.rawValue:
                self.patchUpdateInfo.location = textField.text!
            
            case patchEditionRows.PatchSoilPhLvl.rawValue:
                self.patchUpdateInfo.phLevel = textField.text!
        
            case patchEditionRows.PatchRowQtty.rawValue:
                self.patchUpdateInfo.rowQtty = Int(textField.text!)
            
            case patchEditionRows.PatchRowNamesPrefix.rawValue:
                self.patchUpdateInfo.rowNamesPrefix = textField.text!
            
            default:
                break
        }
    }
}
