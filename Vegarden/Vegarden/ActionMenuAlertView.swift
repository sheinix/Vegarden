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
import DZNEmptyDataSet

let ActionTitleLabelHeight: CGFloat = 60
let CropNameLabelHeight:    CGFloat = 60
let dateLabelHeight:        CGFloat = (CropNameLabelHeight*0.3)
let NotesLabelHeight:       CGFloat = 20
let tableViewMaxHeight:     Int = 450
let rowHeight:              Int = 50
let segControlHeight:       Int = 40
let notesViewHeight:        Int = 100

class ActionMenuAlertView: SCLAlertView {

    var listTableView: UITableView?
    
    var crop: Crop!
    var actionUnit: ActionUnits?
    var growingAction: GrowingActions?
    var isPlantingACrop: Bool?
    var notesTxt : String?
    var notesTxtView: UITextField = UITextField()
    var paddocks : [Paddock]?
    var segControl : UISegmentedControl?
    public var tableViewHeight: Int?
    
    struct Elements {
        
        var patch : Paddock!
        var rowsInPatch : [Row]!
    }
    
    struct ElementActions {
        var row : Row!
        var idx : IndexPath!
    }
    
    var dataSource = [Elements]()
    var rowsToMakeActions = [ElementActions]()
    
    
//MARK: - Initializers
    
    required init(appearance: SCLAppearance, crop: Crop, action: GrowingActions?, unit: ActionUnits, isPlanting: Bool) {
        
        
        self.crop = crop
        self.isPlantingACrop = isPlanting
        self.actionUnit = unit
        self.growingAction = action
        
        self.listTableView = UITableView()//frame: screenBounds, style: UITableViewStyle.plain)
        
        //Set the rows for Planting or GrowingActions:
        
        if (isPlanting) {
            
            self.paddocks = GardenManager.shared.getAllPaddocks()
        
        } else { //Need to get the paddocks from the crop.rows!
            
            if let rows = crop.row?.allObjects as? [Row] {
            
                self.paddocks = rows.map { ($0 as Row).paddock! }.uniqueElements
            }
        }
        
        //Make the datasource with paddocks and freerows for each paddock
        
        //TODO is breaking here with nil when unwrapping optional!
        
        self.dataSource = self.paddocks!.map { Elements(patch: $0, rowsInPatch: (isPlanting ? $0.freeRows : $0.getPlantedRowsFor(crop: crop) )) }
        
        self.rowsToMakeActions.reserveCapacity(self.dataSource.count)
        
        //Need to get the estimated height of the tableView:
        let totalCount = self.dataSource.map { $0.rowsInPatch.count }.reduce(0, +)
        let totalRowSize = (totalCount * rowHeight) + (self.dataSource.count * Int(headerSectionsHeight))
        self.tableViewHeight =  (totalRowSize >= tableViewMaxHeight ? tableViewMaxHeight : totalRowSize)
        
        
        super.init(appearance: appearance)
        
    }
    convenience init(appearance: SCLAppearance, crop: Crop,  action: GrowingActions?, isPlanting boolValue: Bool, and unit: ActionUnits) {
        
        self.init(appearance: appearance, crop: crop, action: action, unit: unit, isPlanting: boolValue)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }

//MARK: - View Life Cycle methods
    
    override func viewDidLoad() {
        
        listTableView?.dataSource = self
        listTableView?.delegate   = self
        listTableView?.emptyDataSetSource = self
        listTableView?.emptyDataSetDelegate = self
        listTableView?.separatorStyle = .none
        listTableView?.isScrollEnabled = (self.tableViewHeight! == tableViewMaxHeight)
        listTableView?.register(DetailPatchRowTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.DetailPatchRowTableViewCellIdentifier)
        
        generateConfirmView()
        
        self.addButton(isPlantingACrop! ? "Plant !" : stringAction(action: self.growingAction!)) {
        
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
    
    private func createTitleSection() -> UIView {
        
        let titleView = UIView()
        //titleView.layer.borderColor = UIColor.lightGray.cgColor
      //  titleView.layer.borderWidth = 1
      //  titleView.layer.cornerRadius = 9

        //Crop Name
        let title = (isPlantingACrop! ? "Plant" : stringAction(action: self.growingAction!))
        
        let cropNameLabel = UILabel()
        cropNameLabel.text =  title! + " " + self.crop.name!
        cropNameLabel.textAlignment = NSTextAlignment.center
        cropNameLabel.font = UIFont.systemFont(ofSize: 30)
        cropNameLabel.textColor = (isPlantingACrop! ? Colors.plantColor :
                                                      colorFor(growingAction: self.growingAction).0)
        
        //Date label
        let dateLabel = UILabel()
        dateLabel.text = Date().inCellDateFormat()
        dateLabel.textAlignment = NSTextAlignment.center
        dateLabel.font = UIFont.systemFont(ofSize: 20)
        dateLabel.textColor = Colors.mainColorUI
        
        //Add them to the view
        titleView.addSubview(cropNameLabel)
        titleView.addSubview(dateLabel)
        
        //Make the Constraints
        cropNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
           // make.height.equalTo(CropNameLabelHeight)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cropNameLabel.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
//            make.height.equalTo(dateLabelHeight)
        }
        
        return titleView
    }

    
    private func createNotesSection() -> UIView {
        
        let notesSection = UIView()
        notesSection.layer.borderColor = UIColor.lightGray.cgColor
        notesSection.layer.borderWidth = 2
        notesSection.layer.cornerRadius = UINumbericConstants.commonCornerRadius
        
        let notesLabel = UILabel()
        notesLabel.textAlignment = NSTextAlignment.left
        notesLabel.text = "Notes:"
        

        //TODO Add customization appearance to the class appearence later
        notesTxtView.placeholder = "Something to add to remember?"
        notesTxtView.font = UIFont.systemFont(ofSize: 15)
        notesTxtView.borderStyle = UITextBorderStyle.none
        notesTxtView.autocorrectionType = UITextAutocorrectionType.no
        notesTxtView.keyboardType = UIKeyboardType.default
        notesTxtView.returnKeyType = UIReturnKeyType.done
        notesTxtView.clearButtonMode = UITextFieldViewMode.whileEditing;
        notesTxtView.contentVerticalAlignment = UIControlContentVerticalAlignment.top
        //notesTextField.delegate = self
        
        notesSection.addSubview(notesLabel)
        notesSection.addSubview(notesTxtView)
        
        
        notesLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.width.greaterThanOrEqualTo(60)
            make.height.equalTo(NotesLabelHeight)
        }
        
        notesTxtView.snp.makeConstraints { (make) in
            make.top.equalTo(notesLabel.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        return notesSection
    }
    
    
    private func createButtonsSection(action: GrowingActions) -> UIView {
    
        let buttonsSection = UIView()
        buttonsSection.layer.borderColor = UIColor.lightGray.cgColor
        buttonsSection.layer.borderWidth = 1
        buttonsSection.layer.cornerRadius = UINumbericConstants.commonCornerRadius//6
        
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

    private func createMainCustomView() -> UIView? {

        let heightSum = (self.tableViewHeight! + Int(CropNameLabelHeight) + segControlHeight + notesViewHeight)
        let newFrame = CGRect(x: self.view.bounds.origin.x,
                              y: self.view.bounds.origin.y,
                          width: self.view.bounds.width,
                         height: CGFloat(heightSum + 70))
        
        
        let mainCustomView = UIView(frame: newFrame)
        mainCustomView.clipsToBounds = true
        
        let titleView = createTitleSection()
        let notesView = createNotesSection()
        //let buttonView = createButtonsSection(action: action)
    
        
        mainCustomView.addSubview(titleView)
        mainCustomView.addSubview(self.listTableView!)
        mainCustomView.addSubview(notesView)
       // mainCustomView.addSubview(buttonView)
    
        titleView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(CropNameLabelHeight)
        }
        
        if (isPlantingACrop)! { //If its planting a Crop should show the Seed/Seedling segmentControl
            
            confirgureSegmentedControl()
            mainCustomView.addSubview(self.segControl!)
            
            self.segControl?.snp.makeConstraints({ (make) in
                make.left.equalToSuperview()
                make.right.equalToSuperview().offset(-24)
                make.top.equalTo(titleView.snp.bottom).offset(10)
                make.height.equalTo(segControlHeight)
            })
        }

        listTableView?.snp.makeConstraints { (make) in
            make.top.equalTo( (isPlantingACrop! ? self.segControl!.snp.bottom : titleView.snp.bottom)).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(self.tableViewHeight!)
        }
        
        notesView.snp.makeConstraints { (make) in
            make.top.equalTo((listTableView?.snp.bottom)!)
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(notesViewHeight)
        }
        
        return mainCustomView
    }
    
    private func confirgureSegmentedControl() {
    
        self.segControl = UISegmentedControl(items: ["Seed", "Seedling"])
        
        if let segmented = self.segControl {
            
            segmented.layer.cornerRadius = UINumbericConstants.commonCornerRadius
            segmented.layer.borderColor = Colors.plantColor.cgColor
            segmented.layer.borderWidth = 1
            segmented.layer.masksToBounds = true
            segmented.tintColor = Colors.plantColor
            segmented.selectedSegmentIndex = 0
        }
    }
    
    public func generateConfirmView() {
        
        guard let _ = self.crop else { return }
        
        let subView = createMainCustomView()
        
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
            case GrowingActions.UnplantAction:
                strAction = "Unplant"
//            default:
//                break
            }
        
            return strAction
            
    }
    
    private func showAlert () {
//        let frame = CGRect(x: self.view.bounds.origin.x,
//                           y: self.view.bounds.origin.y,
//                           width: 100,
//                           height: 100)
        
        let alert = UIAlertController(title: "Hold on Mate!",
                                      message: "Select at least one row!",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { (action:UIAlertAction!) in
                                        
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion:nil)
        

    }
    
    private func confirmButtonPressed() {
        
        guard let _ = self.crop else { return }
        
        let rows : [Row] = rowsToMakeActions.flatMap { $0.row }
        
        if (rows.count == 0) {   showAlert() ;  return    }
        
        let notesString : String? = ((!(notesTxtView.text?.isEmpty)!) ? notesTxtView.text : nil)
        
        if (isPlantingACrop)! {
            
            let plantToBeMade = PlantDTO(with: rows,
                                         crop: self.crop!,
                                         notes: notesString,
                                         and: plantingStates(rawValue: self.segControl!.selectedSegmentIndex)!)
                
            GardenManager.shared.plant(plantAction: plantToBeMade)
            
            
        } else {
            
            let actionToBeMade = ActionMadeDTO(with: rows,
                                               crop: self.crop!,
                                               notes: notesString,
                                               and: self.growingAction!)

            GardenManager.shared.make(action: actionToBeMade)
        }
        
        
    }
}



extension ActionMenuAlertView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       //TODO For now, just do actions on rows, its a design thing to think if we can do actions on patch or crop

        return dataSource[section].rowsInPatch.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.DetailPatchRowTableViewCellIdentifier) as! DetailPatchRowTableViewCell!
        
        let row : Row = dataSource[indexPath.section].rowsInPatch[indexPath.row]
      
        cell?.rowName.text = row.name
        
       let switchChanged = #selector(switchChangedFor)
        cell?.switchControl.addTarget(self, action: switchChanged, for: UIControlEvents.valueChanged)
        cell?.switchControl.onTintColor = (isPlantingACrop! ? Colors.plantColor :
                                                            colorFor(growingAction: self.growingAction).0)
        
        
        if ((rowsToMakeActions.filter { $0.idx == indexPath }).count) == 0 {
            
            cell?.switchControl.isOn = false
        
        } else {
            
            cell?.switchControl.isOn = true
        }

        return cell!
    }
    
    
    @objc func switchChangedFor(sender: Any) {

        let view = (sender as! UISwitch).superview!.superview
        
        if (view is DetailPatchRowTableViewCell) {
           
            if let idxPath = self.listTableView?.indexPath(for: (view as! DetailPatchRowTableViewCell)) {
                
                let patch = dataSource[idxPath.section]
                let row = patch.rowsInPatch[idxPath.row]
                
                if ((view as! DetailPatchRowTableViewCell).switchControl.isOn) {
                    rowsToMakeActions.append(ElementActions(row: row, idx: idxPath))
                } else {
                    rowsToMakeActions = rowsToMakeActions.filter { $0.idx != idxPath }
                }
                
                self.listTableView?.reloadRows(at: [idxPath], with:UITableViewRowAnimation.none)
                let idx = IndexSet(arrayLiteral: idxPath.section)
                self.listTableView?.reloadSections(idx, with: UITableViewRowAnimation.none)
                
                
            }
            
        } else { //is the switch from the header
            
            //Switch on all the switchs from the rows of sections
            let header = (view as! ActionMenuAlertTableHeaderView)
            let section = header.tag
          
            if (header.switchAll.isOn) {   //Need to add the newRows that weren't previously added
                
                var allRowsInSectionSet = Set(self.dataSource[section].rowsInPatch)
                let alreadyAddedRows : [Row] = rowsToMakeActions.filter { $0.idx.section == section }.map { $0.row }
                
                let addedRowsSet = Set(alreadyAddedRows)
                
                var newRows : [Row]
                
                if (addedRowsSet.count > 0 ) {
                    
                   allRowsInSectionSet.subtract(addedRowsSet)
                   newRows = Array(allRowsInSectionSet)
        
                } else {
                    
                    newRows = self.dataSource[section].rowsInPatch
                }
                
                newRows.forEach({ (row) in
                    
                    let rowNum = (self.dataSource[section].rowsInPatch).index(of: row)
                    let idx = IndexPath(row: rowNum!, section: section)
                    
                    rowsToMakeActions.append(ElementActions(row: row, idx: idx))
                    
                })
                
            } else { // Just remove the rows of the section
                
                 rowsToMakeActions = rowsToMakeActions.filter { $0.idx.section != section }
            }
            
            let idx = IndexSet(arrayLiteral: section)
            self.listTableView?.reloadSections(idx, with: UITableViewRowAnimation.none)
          
        }

    }
    
   // func tableView heihg
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
      return createHeaderFor(tableView: tableView, section: section)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
      return headerSectionsHeight
        
    }

    private func createHeaderFor(tableView: UITableView, section: Int) -> UIView {
        
        let headerView = ActionMenuAlertTableHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: headerSectionsHeight))
        
        headerView.backgroundColor = (isPlantingACrop! ? Colors.plantColor :
                                                        colorFor(growingAction: self.growingAction).0)
        headerView.titleLabel.text = self.dataSource[section].patch.name
        
        let shouldShowHeader = (self.dataSource[section].rowsInPatch.count > 0)
        
        headerView.fullPatchLabel.isHidden = shouldShowHeader
        headerView.switchTitle.isHidden = !shouldShowHeader
        headerView.switchAll.isHidden = !shouldShowHeader
        headerView.switchAll.onTintColor = (isPlantingACrop! ? Colors.plantColor : colorFor(growingAction: self.growingAction).0)
        
        headerView.switchAll.addTarget(self, action: #selector(switchChangedFor), for: UIControlEvents.valueChanged)
        //Use the tag to recognize later the section that corresponds:
        headerView.tag = section
        
//        let numRowsActions = rowsToMakeActions.filter { $0.idx.section == section }.count
//        let numRowsSection = self.dataSource[section].rowsInPatch.count
        
        headerView.switchAll.setOn(areAllRowsSelectedIn(section: section), animated: false)
        
        
        return headerView
        
    }
    
    private func areAllRowsSelectedIn(section: Int) -> Bool {
        
        let numRowsActions = rowsToMakeActions.filter { $0.idx.section == section }.count
        let numRowsSection = self.dataSource[section].rowsInPatch.count
        
       return (numRowsActions == numRowsSection)

    }
}
extension ActionMenuAlertView : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        
        return (UIImage(named: "NoAvailablePaddocks"))
        
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        
        let msg = NSMutableAttributedString(string: "Oops! No Patches Added yet!",
                                            attributes: [NSFontAttributeName:Fonts.mainFont])
        msg.addAttribute(NSForegroundColorAttributeName,
                         value: Colors.mainColorUI,
                         range: NSRange(location:0, length:msg.length))
        
        
        return msg
        
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let text = "Start adding a new Patch on My Garden section! ";
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center;
        
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14),
                          NSForegroundColorAttributeName: UIColor.lightGray,
                          NSParagraphStyleAttributeName: paragraph]
        
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.white
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        
        return CGFloat(integerLiteral: 15)
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
