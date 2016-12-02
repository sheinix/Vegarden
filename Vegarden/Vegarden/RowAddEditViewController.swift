//
//  RowAddEditViewController.swift
//  Vegarden
//
//  Created by Sarah Cleland on 2/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SCLAlertView
import SnapKit
import SkyFloatingLabelTextField

class RowAddEditViewController: SCLAlertView {

    var isAddingRows : Bool?
    var rowsTableView: UITableView = UITableView(frame: screenBounds, style: UITableViewStyle.plain)
    var rowsAddUpdateInfo = RowsInfo()
    var rowList : [Any] = []
    var patch : Paddock?
    
    required init(appearance: SCLAppearance, patch: Paddock?) {
        
        super.init(appearance: appearance)
        
        self.patch = patch
        self.rowList = (patch?.rows?.allObjects)!
        self.rowsAddUpdateInfo.patch = patch
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    fileprivate func setupViews () {
        
        self.rowsTableView.delegate = self
        self.rowsTableView.dataSource = self
        
        self.rowsTableView.register(PatchEditionTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.PatchEditionCellIdentifier)
        self.rowsTableView.isScrollEnabled = true
        self.rowsTableView.separatorStyle = .none
        
        self.customSubview = self.rowsTableView
        self.customSubview?.clipsToBounds = true
        self.customSubview?.layer.masksToBounds = true
        
        self.addButton("Confirm") {
            
            self.confirmButtonPressed()
        }
        
    }
    
    fileprivate func confirmButtonPressed() {
        
        
    }

}
extension RowAddEditViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rowList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.PatchEditionCellIdentifier) as! PatchEditionTableViewCell)
        
        
        if let aRow = self.rowList[indexPath.row] as? Row {
            cell.txtField.placeholder = aRow.name!
        } else if let newRow = self.rowList[indexPath.row] as? newRow {
            cell.txtField.placeholder = newRow.name!
        }
    
        cell.txtField.delegate = self
        cell.txtField.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            self.rowsAddUpdateInfo.deletedRows?.append(self.rowList[indexPath.row] as! Row)
            self.rowList.remove(at: indexPath.row)
            self.rowsTableView.deleteRows(at: [indexPath], with: .fade)
            
    
        } else if editingStyle == .insert {
            
            let aNewRow = newRow(name:  (self.patch?.rowsNamePrefix)! + "_ complete row name")
            self.rowsAddUpdateInfo.newRows?.append(aNewRow)
            self.rowList.insert(aNewRow, at: indexPath.row)
            self.rowsTableView.insertRows(at: [indexPath], with: .fade)
        }
    }
}
extension RowAddEditViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
            if (floatingLabelTextField.text?.isEmpty)! {
                floatingLabelTextField.errorMessage = "Provide a name please"
            } else {
                floatingLabelTextField.errorMessage = ""
            }
        }
        
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let txtField = textField as? SkyFloatingLabelTextField else  { return }
        
        if (txtField.text?.isEmpty)! {
            txtField.errorMessage = "Provide a name please"
        } else {
            txtField.errorMessage = ""
            
            //Check if its a new row or not:
            
            if let aRow = self.rowList[textField.tag] as? Row { //old row
                self.rowsAddUpdateInfo.addEdited(row: aRow)
            }
        }

    }
    
    
    
}

