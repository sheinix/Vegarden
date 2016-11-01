//
//  ActionMenuAlertView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 27/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import Foundation
import SCLAlertView
import SnapKit

let ActionTitleLabelHeight: CGFloat = 60
let CropNameLabelHeight:    CGFloat = 60
let dateLabelHeight:        CGFloat = (CropNameLabelHeight*0.3)
let NotesLabelHeight:       CGFloat = 20

class ActionMenuAlertView: SCLAlertView {

    var listTableView: UITableView = UITableView(frame: screenBounds, style: UITableViewStyle.plain)
    var crop: Crop!
    var actionUnit: ActionUnits?
    var growingAction: GrowingActions!
    var notesTxt : String?
    var allRows: Bool = false
    
    var rows : [Row]?
    var rowsToMakeActions : [Row]?
    
    
//MARK: - Initializers
    
    required init(with crop: Crop, action: GrowingActions, and unit:ActionUnits) {
        
        self.crop = crop
        if let rows = crop.row {
            self.rows = (rows.allObjects as! [Row])
        }
        
        self.actionUnit = unit
        self.growingAction = action
        self.rowsToMakeActions?.reserveCapacity((self.rows?.count)!)
       
        super.init()
    }
    
    public init(appearance: SCLAppearance, crop: Crop, action: GrowingActions, and unit: ActionUnits) {
        
        self.crop = crop
        if let rows = crop.row {
            self.rows = (rows.allObjects as! [Row])
        }

        self.actionUnit = unit
        self.growingAction = action
        self.rowsToMakeActions?.reserveCapacity((self.rows?.count)!)
       
        super.init(appearance: appearance)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }

//MARK: - View Life Cycle methods
    
    override func viewDidLoad() {
        
        listTableView.dataSource = self
        listTableView.delegate   = self
        
        listTableView.register(DetailPatchRowTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.DetailPatchRowTableViewCellIdentifier)
        
        generateConfirmView()
        
        self.addButton("Confirm") { 
        
            self.confirmButtonPressed()
        }
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
       
        super.didReceiveMemoryWarning()
       
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        if (self.customSubview?.superview) != nil {
        
        self.customSubview?.frame =  self.viewText.frame
    
        }
    }
    
    
//MARK: - View Creations Methods
    
    private func createTitleSection(action: GrowingActions, crop: Crop) -> UIView {
        
//        let frame = CGRect(origin: CGPoint.zero,
//                             size: CGSize(width: self.view.frame.width, height: ActionTitleLabelHeight))
        
        let titleView = UIView()
        titleView.layer.borderColor = UIColor.lightGray.cgColor
        titleView.layer.borderWidth = 1
        titleView.layer.cornerRadius = 6
        titleView.backgroundColor = UIColor.brown
        //Action made:
//        let titleAction = UILabel()
//        titleAction.textAlignment = NSTextAlignment.center
//        titleAction.text = stringAction(action: action)
        
        
        //Crop Name
        let cropNameLabel = UILabel()
        cropNameLabel.text = crop.name
        cropNameLabel.textAlignment = NSTextAlignment.center
        
        //Date label
        let dateLabel = UILabel()
        dateLabel.text = Date().inCellDateFormat()
        dateLabel.textAlignment = NSTextAlignment.center
        
        //Add them to the view
    //    titleView.addSubview(titleAction)
        titleView.addSubview(cropNameLabel)
        titleView.addSubview(dateLabel)
        
        //Make the Constraints
        
//        titleAction.snp.makeConstraints { (make) in
//            make.top.equalToSuperview()
//            make.left.equalToSuperview().offset(5)
//            make.right.equalToSuperview().offset(-5)
//            make.height.equalTo(ActionTitleLabelHeight)
//        }
        
        cropNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(CropNameLabelHeight)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cropNameLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(dateLabelHeight)
        }
        
        return titleView
    }

    
    private func createNotesSection() -> UIView {
        
        let notesSection = UIView()
        notesSection.layer.borderColor = UIColor.lightGray.cgColor
        notesSection.layer.borderWidth = 1
        notesSection.layer.cornerRadius = 6
        
        let notesLabel = UILabel()
        notesLabel.textAlignment = NSTextAlignment.left
        notesLabel.text = "Notes:"
        
        let notesTextField = UITextField()
        
        //TODO Add customization appearance to the class appearence later
        notesTextField.placeholder = "Something to add for remembering?"
        notesTextField.font = UIFont.systemFont(ofSize: 15)
        notesTextField.borderStyle = UITextBorderStyle.line
        notesTextField.autocorrectionType = UITextAutocorrectionType.no
        notesTextField.keyboardType = UIKeyboardType.default
        notesTextField.returnKeyType = UIReturnKeyType.done
        notesTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        notesTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.top
        //notesTextField.delegate = self
        
        notesSection.addSubview(notesLabel)
        notesSection.addSubview(notesTextField)
        
        
        notesLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.width.greaterThanOrEqualTo(60)
            make.height.equalTo(NotesLabelHeight)
        }
        
        notesTextField.snp.makeConstraints { (make) in
            make.top.equalTo(notesLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(5)
        }
        
        return notesSection
    }
    
    
    private func createButtonsSection(action: GrowingActions) -> UIView {
    
        let buttonsSection = UIView()
        buttonsSection.layer.borderColor = UIColor.lightGray.cgColor
        buttonsSection.layer.borderWidth = 1
        buttonsSection.layer.cornerRadius = 6
        
        let cancelButton = UIButton(type: UIButtonType.custom)
        cancelButton.titleLabel?.text = "Cancel"
        cancelButton.titleLabel?.textAlignment = NSTextAlignment.center
        cancelButton.backgroundColor = UIColor.red
        
        let doneButton = UIButton(type: UIButtonType.custom)
        doneButton.titleLabel?.text = stringAction(action: action)
        doneButton.titleLabel?.textAlignment = NSTextAlignment.center
        doneButton.backgroundColor = UIColor.green
        
        buttonsSection.addSubview(doneButton)
        buttonsSection.addSubview(cancelButton)
        
        doneButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(5)
            //make.right.equalTo(cancelButton.snp.left).offset(5)
            make.top.equalToSuperview().offset(5)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(5)
            //make.left.equalTo(doneButton.snp.left).offset(5)
            make.top.equalToSuperview().offset(5)
            make.width.equalTo(doneButton.snp.width)
        }
        
        return buttonsSection
    }

    public func createMainCustomView(with action: GrowingActions, and crop: Crop) -> UIView {
        
        let frame = CGRect(x: 0, y: 0, width: screenWidth * 0.9, height: screenHeight*0.9)
        
        let mainCustomView = UIView(frame: frame)
        mainCustomView.clipsToBounds = true
        
        
        let titleView = createTitleSection(action: action, crop: crop)
        let notesView = createNotesSection()
        //let buttonView = createButtonsSection(action: action)
    
        mainCustomView.addSubview(titleView)
        mainCustomView.addSubview(self.listTableView)
        mainCustomView.addSubview(notesView)
       // mainCustomView.addSubview(buttonView)
    
        titleView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leftMargin.equalToSuperview()
            make.rightMargin.equalToSuperview().offset(-10)
          //  make.width.lessThanOrEqualToSuperview()
            make.height.equalTo(80)
        }
        
        listTableView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(mainCustomView.frame.height * 0.5)
        }
        
        notesView.snp.makeConstraints { (make) in
            make.top.equalTo(listTableView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
         //   make.bottom.equalTo(buttonView.snp.top)
            make.bottom.equalToSuperview().offset(-10)
        }
        
//        buttonView.snp.makeConstraints { (make) in
//            //make.top.equalToSuperview()
//            make.left.equalToSuperview()
//            make.right.equalToSuperview().offset(-10)
//            make.bottom.equalToSuperview()
//        }
        
        return mainCustomView
    }
    
    public func generateConfirmView() {
        
        guard let _ = self.crop else { return }
        
        let subView = createMainCustomView(with: self.growingAction, and: self.crop!)
        
        self.customSubview = subView
        self.customSubview?.clipsToBounds = true
        self.customSubview?.layer.masksToBounds = true
//        self.customSubview?.snp.makeConstraints { (make) in
//            make.edges.equalTo(self.contentView.snp.edges)
//        }
        
    }
    
    public func stringAction (action: GrowingActions) -> String! {
    
        let strAction : String
        
            switch action {
            case GrowingActions.FertilizeAction:
                strAction = "Fertilize"
            case GrowingActions.WaterAction:
                strAction = "Water"
            case GrowingActions.WeedAction:
                strAction = "Weed"
            case GrowingActions.HarvestAction:
                strAction = "Harvest"
            case GrowingActions.FinishAction:
                strAction = "Finish Harvest"
 
            default:
                break
            }
        
            return strAction
            
        }
    
    private func confirmButtonPressed() {
        
        guard let _ = self.growingAction , let _ = self.crop else { return }
        
        var notesString : String?
        
        self.customSubview!.subviews.forEach { (view) in
            if (view is UITextView) {
                if (!(view as! UITextView).text.isEmpty) {
                    notesString = (view as! UITextView).text
                }
            }
        }
        

        let actionToBeMade = ActionMadeDTO(with: rowsToMakeActions!,
                                           crop: self.crop,
                                           notes: notesString,
                                           and: self.growingAction)
        
        
        GardenManager.shared.make(action: actionToBeMade)
        
    }
}


//extension ActionMenuAlertView : UITextViewDelegate {
//    
//    
//}


extension ActionMenuAlertView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       //TODO For now, just do actions on rows, its a design thing to think if we can do actions on patch or crop

        return rows!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            //TODO Use the function!
        return 3 //rows.map { $0.paddock }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.DetailPatchRowTableViewCellIdentifier) as! DetailPatchRowTableViewCell!
        
        cell?.rowName.text = rows?[indexPath.row].name
        cell?.switchControl.addTarget(self, action: #selector(ActionMenuAlertView.switchChangedFor(index:)), for: UIControlEvents.valueChanged)
        
        
        return cell!
    }
    
    public func switchChangedFor(index: IndexPath) {
      
        
        //if (allRows) { rowsToMakeActions = rows ; return }
        
    //TODO use the row object!
    
        let cell : DetailPatchRowTableViewCell = (tableView(self.listTableView, cellForRowAt: index) as! DetailPatchRowTableViewCell)
    
        
        if (cell.switchControl.isOn) {
           
            rowsToMakeActions?.insert((rows?[index.row])!, at: index.row)
            
        } else {
            
            rowsToMakeActions?.remove(at: index.row)
        }
        
        
        
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        let paddocks = rows.map { $0.paddock?.name }
//        let distinct = paddocks.filter { ($0?.contains($0))! }
//        
//        
//        
//    }
    
   
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        
//        
//        
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        
//        return tableView.headerView(forSection: section)?.frame.height
//        
//    }

}
