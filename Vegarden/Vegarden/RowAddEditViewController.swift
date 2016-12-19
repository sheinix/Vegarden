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

let tableHeaderHeight = 70

class RowAddEditViewController: SCLAlertView {

    var isAddingRows : Bool?
    var rowsTableView: UITableView?
    var rowsAddUpdateInfo : RowsInfo!
    var rowList : [Any] = []
    var patch : Paddock!
    
    required init(appearance: SCLAppearance, patch: Paddock?) {
        
        self.patch = patch
        self.rowList = (patch?.rows?.allObjects)!
        self.rowsAddUpdateInfo = RowsInfo(paddock: self.patch)
            
        super.init(appearance: appearance)
        
        //self.rowsTableView.frame = self.view.bounds
       
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupViews()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    fileprivate func setupViews () {

        let tableHeight =  self.rowList.count * patchRowHeight + tableHeaderHeight
        
        
        
        let frame = CGRect(x: 0, y: 0,
                           width: Int(self.view.bounds.width - 140), height:(tableHeight < tableViewMaxHeight ? tableHeight : tableViewMaxHeight))
        
        self.rowsTableView = UITableView(frame:frame, style: UITableViewStyle.plain)
        self.rowsTableView?.delegate = self
        self.rowsTableView?.dataSource = self
        
        self.rowsTableView?.register(PatchEditionTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.RowsEditionCellIdentifier)
        self.rowsTableView?.isScrollEnabled = true
        self.rowsTableView?.separatorStyle = .none
        
        self.customSubview = self.rowsTableView
        self.customSubview?.clipsToBounds = true
        self.customSubview?.layer.masksToBounds = true
        
        self.addButton("Confirm") {
            
            self.confirmButtonPressed()
        }
        
    }
    
    fileprivate func confirmButtonPressed() {
        
        //Send a resign first responder in order to resign all textfields that has data!
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
        
        GardenManager.shared.makeRowsEditions(rowsInfo: self.rowsAddUpdateInfo)
        
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
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.RowsEditionCellIdentifier) as! PatchEditionTableViewCell)
        
        
        if let aRow = self.rowList[indexPath.row] as? Row {
            
            cell.txtField.text = aRow.name!
            cell.txtField.titleLabel.text = ""
            cell.needsRemakeConstraints(hasPlantedRow: aRow.isPlanted)
            
            
        } else if let newRow = self.rowList[indexPath.row] as? newRow {
            
                cell.txtField.placeholder = newRow.name!
                cell.txtField.text = (cell.txtField.text != newRow.name! ?
                    "": cell.txtField.text)
            
            
            
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
            self.rowsTableView?.deleteRows(at: [indexPath], with: .fade)
            
    
        } else if editingStyle == .insert {
            
//            let aNewRow = newRow(name:  (self.patch?.rowsNamePrefix)! + "_ complete row name")
//            self.rowsAddUpdateInfo.newRows?.append(aNewRow)
//            self.rowList.insert(aNewRow, at: indexPath.row)
//            self.rowsTableView.insertRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if let row = self.rowList[indexPath.row] as? Row {
            return !row.isPlanted
        }
        
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(tableHeaderHeight)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return setupHeaderView()
        
    }
    
    @objc func addRow(sender: UIButton) {
        
        let aNewRow = newRow(name:  (self.patch?.rowsNamePrefix)! + "_ complete row name")
//        self.rowsAddUpdateInfo.newRows?.append(aNewRow)
        self.rowList.insert(aNewRow, at: 0)
        
        // Update Table Data
        self.rowsTableView?.beginUpdates()
        
        self.rowsTableView?.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        
        self.rowsTableView?.endUpdates()
        
    }
    
    fileprivate func setupHeaderView() -> UIView {
       
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: Int((self.rowsTableView?.bounds.width)!), height: tableHeaderHeight))
        
        headerView.backgroundColor = Colors.mainColorUI
        headerView.layer.cornerRadius = UINumbericConstants.commonCornerRadius
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        let addButton = UIButton(type: .custom)
        addButton.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        titleLabel.textColor = UIColor.white
        titleLabel.font = Fonts.appleGoticUltraLightFont
        titleLabel.text = self.patch.name
        
        addButton.setImage(UIImage(named:"plusbuttonwhite"), for: .normal)
        addButton.addTarget(self, action: #selector(addRow), for: .touchUpInside)
        
        headerView.addSubview(addButton)
        headerView.addSubview(titleLabel)
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        addButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        return headerView

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
                
                aRow.name = txtField.text
                self.rowsAddUpdateInfo.addEdited(row: aRow)
                
            } else if self.rowList[textField.tag] is newRow {
                
                    var newRowie = (self.rowList[textField.tag] as! newRow)
                    newRowie.name = txtField.text
                    self.rowsAddUpdateInfo.newRows?.append(newRowie)
            }
        }
    }
    
}

