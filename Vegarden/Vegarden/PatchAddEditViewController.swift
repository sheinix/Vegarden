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
import SkyFloatingLabelTextField
import DZNEmptyDataSet

let patchRowHeight = 60

class PatchAddEditViewController: SCLAlertView {

    var patch : Paddock?
    var patchInfoTableView: UITableView?
    var isAddingNewPatch : Bool!
    var tableViewHeight : Int?
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
        
        let tableHeight = patchRowHeight * 5
        self.patchInfoTableView = UITableView(frame: CGRect(x: 0, y: 0,
                                                            width: Int(self.view.bounds.width),
                                                            height: tableHeight), style: .plain)
        self.patchInfoTableView?.dataSource = self
        self.patchInfoTableView?.delegate = self
        self.patchInfoTableView?.register(PatchEditionTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.PatchEditionCellIdentifier)
        self.patchInfoTableView?.isScrollEnabled = false
        self.patchInfoTableView?.separatorStyle = .none
        

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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(patchRowHeight)
    }
}
extension PatchAddEditViewController : UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
         
            switch floatingLabelTextField.tag {
                case patchEditionRows.PatchSoilPhLvl.rawValue, patchEditionRows.PatchRowQtty.rawValue:
                
                    if (!floatingLabelTextField.hasOnlyNumbers()) {
                        floatingLabelTextField.errorMessage = "Invalid Number"
                    } else {
                        floatingLabelTextField.errorMessage = ""
                    }
                
            default:
                break
            }
        }
        return true
    }
    
//    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        
//        KJ
//        
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let txtField = textField as? SkyFloatingLabelTextField else  { return }
        
        switch txtField.tag {
            
            case patchEditionRows.PatchName.rawValue:
                self.patchUpdateInfo.name = txtField.text!
            
            case patchEditionRows.PatchLocation.rawValue:
                self.patchUpdateInfo.location = txtField.text!
            
            case patchEditionRows.PatchSoilPhLvl.rawValue:
               
                validate(txtField: txtField, type: patchEditionRows.PatchSoilPhLvl)

           
            case patchEditionRows.PatchRowQtty.rawValue:
            
                validate(txtField: txtField, type: patchEditionRows.PatchRowQtty)
            
            
            case patchEditionRows.PatchRowNamesPrefix.rawValue:
                self.patchUpdateInfo.rowNamesPrefix = txtField.text!
            
            default:
                break
        }
    }
    
fileprivate func validate(txtField : SkyFloatingLabelTextField, type : patchEditionRows) {

        if (!txtField.hasOnlyNumbers()) { //Check for numbers in txtfield
            
            txtField.errorMessage = "Invalid Number"

            self.showSimpleAlertViewWith(title: (type == .PatchSoilPhLvl ? "Ph Level" :
                                                                           "Row Quantity"),
                                       message: (type == .PatchSoilPhLvl ? "Ph Level must be a number!" :
                                        "Number of Rows must be a number!"),
                                        style: .alert)
            }

         else {
            
            if (type == .PatchSoilPhLvl) { self.patchUpdateInfo.phLevel = txtField.text }
           
            else if (self.isAddingNewPatch!) {
                
                    self.patchUpdateInfo.rowQtty = Int(txtField.text!)
                
                 } else { //Check if its modifying num rows, validate planted ones!
                
                if  (Int(txtField.text!)! > (self.patch?.rows?.count)!) ||
                    (Int(txtField.text!)! >= (self.patch?.plantedRows.count)!) {
                    
                    self.patchUpdateInfo.rowQtty = Int(txtField.text!)
                    
                } else {
                    
                    self.showSimpleAlertViewWith(title: "Number of Rows" ,
                                                 message: "You are trying to modifiy a Patch with planted Rows. Please Check on the Delete Rows option before!",
                                                 style: .alert)
                }
            }
        }
    }
    
    
}
