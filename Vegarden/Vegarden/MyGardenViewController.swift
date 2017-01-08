//
//  MyGardenViewController.swift
//  
//
//  Created by Sarah Cleland on 28/11/16.
//
//

import UIKit
import SCLAlertView
import DZNEmptyDataSet

let rowsMaxHeight = UIScreen.main.bounds.height/3
let headerHeight = 80

enum patchAction : Int {
    case AddPatch, DeletePatch
}

class MyGardenViewController: UITableViewController, TableHeaderAddButtonProtocol {

    let totalPlantedCrops : Int = (GardenManager.shared.myPlantedCrops()?.count)!
    var totalPaddocks : Int = (GardenManager.shared.getMyGarden().paddocks?.count)!
    var patchs : [Paddock] = (GardenManager.shared.getMyGarden().paddocks?.allObjects as! [Paddock])
    var rowsHeight : CGFloat?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
     //   self.tableView.rowHeight = UITableViewAutomaticDimension
        self.rowsHeight = (CGFloat(totalPlantedCrops) * CGFloat(cropRowHeight)) + CGFloat(headerHeight)
        self.tableView.estimatedRowHeight = self.rowsHeight!
        
        let tableHeader = MyGardenHeaderView.loadFromNibNamed(nibNamed: "MyGardenHeaderView")
        self.tableView.tableHeaderView = tableHeader
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.isScrollEnabled = true
        
        addObservers()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    fileprivate func addObservers() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(newPatchAdded),
                                               name: NSNotification.Name(rawValue: NotificationIds.NotiKeyNewPatch),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(patchDeleted),
                                               name: NSNotification.Name(rawValue: NotificationIds.NotiKeyPatchDeleted),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(patchRowEdited),
                                               name: NSNotification.Name(rawValue: NotificationIds.NotiKeyPatchEdited),
                                               object: nil)
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(patchRowEdited),
                                               name: NSNotification.Name(rawValue: NotificationIds.NotiKeyRowsEdited),
                                               object: nil)
      
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(patchRowEdited),
                                               name: NSNotification.Name(rawValue: NotificationIds.NotiKeyRowsAdded),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(patchRowEdited),
                                               name: NSNotification.Name(rawValue: NotificationIds.NotiKeyRowsDeleted),
                                               object: nil)
        }
 
    fileprivate func reloadSectionFor(action: patchAction) {
        
        DispatchQueue.main.async {
            
            if (action == .AddPatch) { self.totalPaddocks += 1 } else { self.totalPaddocks -= 1 }
            
            //self.totalPaddocks += 1
            let header = (self.tableView(self.tableView, viewForHeaderInSection: 1) as! MyGardenTableSectionHeaderView)
            header.titleLabel.text = "My Garden | Number of Patchs : " + String(self.totalPaddocks)
            self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
        }

    }
    
    
    @objc fileprivate func newPatchAdded(notification: NSNotification) {
        
        guard let patch = notification.userInfo?["patch"] as? Paddock else { return }
        
        self.patchs.append(patch)
        self.view.showConfirmViewWith(title: "Patch Added!",
                                      frame: self.view.bounds,
                                      afterAction: nil)

        reloadSectionFor(action: .AddPatch)
        
    }
    
    
    @objc fileprivate func patchDeleted(notification: NSNotification) {
        
        guard let patch = notification.userInfo?["patch"] as? Paddock else { return }
        
        let idx = self.patchs.index(of: patch)
        self.patchs.remove(at: idx!)
        
        self.view.showConfirmViewWith(title: "Patch Deleted!", frame: self.view.bounds, afterAction: nil)

        reloadSectionFor(action: .DeletePatch)
    }

    
   @objc fileprivate func patchRowEdited(notification: NSNotification) {
    
        guard let cell = self.tableView.cellForRow(at: IndexPath(row:0, section:1)) as?  MyGardenDetailTableViewCell else { return }
    
        if let myCV = cell.myGardenCollectionView { DispatchQueue.main.async { myCV.reloadData() } }
    
        self.view.showConfirmViewWith(title: screenMessage(notiId: notification.name.rawValue),
                                      frame: nil,
                                afterAction: nil)
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
            if let table = (cell as! MyGardenOverviewTableViewCell).cropsTableView {
                table.isScrollEnabled = (self.rowsHeight! > rowsMaxHeight)
            }
        
        } else {
            cell = (tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MyGardenDetailCellIdentifier, for: indexPath) as! MyGardenDetailTableViewCell)
            if let collection = (cell as! MyGardenDetailTableViewCell).myGardenCollectionView {
                
                collection.delegate = self
                collection.dataSource = self
                collection.emptyDataSetDelegate = self
                collection.emptyDataSetSource = self
                
                collection.reloadData()
            }
            
        }
        

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = MyGardenTableSectionHeaderView(frame: CGRect(x: 2, y: 0, width: Int(screenWidth)-2, height: headerHeight))
        
        let title = (section == 0 ? "Overview  |  Planted Crops : " + String(self.totalPlantedCrops) : "My Garden | Number of Patchs : " + String(self.totalPaddocks))
        
        header.titleLabel.text = title
        header.addPatchButton.isHidden = (section == 0)
        header.delegate = self
        return header
        
    }
    
    func didPushAddButton(button: UIButton) {
        
        showAddEditPatch(patch: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(headerHeight)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //If we dont have any rows planted:
       // if self.totalPlantedCrops == 0 { realHeight = CGFloat(250) }
        
        let realHeight = ((self.rowsHeight! - CGFloat(headerHeight)) > CGFloat(integerLiteral: cropRowHeight) ?
            self.rowsHeight : 255)
        
        if  (indexPath.section == 0) {
            
            return (self.rowsHeight! > rowsMaxHeight ? rowsMaxHeight : realHeight!)
        
        } else {
            
            return (self.rowsHeight! > rowsMaxHeight ? rowsMaxHeight : screenHeight - realHeight!)
        }
        
        
        //return (indexPath.section == 0 ? self.rowsHeight! : screenHeight - self.rowsHeight!)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0 ? self.rowsHeight! : screenHeight - self.rowsHeight!)
    }
    
    fileprivate func showAddEditPatch(patch: Paddock?) {
        
        let appearance = Appereance().appereanceForAlert(frame: self.view.bounds, color: Colors.mainColorUI, needsTitle: true)
        
        let alert = PatchAddEditViewController(appearance: appearance, patch: patch)
        
        let _ = alert.showInfo((patch != nil ? (patch?.name!)! : "Add New Patch"),
                               subTitle: "",
                               closeButtonTitle: "Close",
                               duration: 0,
                               colorStyle: Colors.mainColorHex,
                               colorTextButton: 0xFFFFFF,
                               animationStyle: .topToBottom)
        
        
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
        cell.applyLightShadow()
        
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
                                         message: "The Patch has planted Rows. Remove all crops in this patch from the LifeCycle screen before deleting it ",
                                         style: .alert)
            
        }
    }
}
extension MyGardenViewController : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        
        return (UIImage(named: "NoAvailablePaddocks"))
        
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        
        let msg = NSMutableAttributedString(string: "Oops! No Available Patches!",
                                            attributes: [NSFontAttributeName:Fonts.emptyStateFont])
        msg.addAttribute(NSForegroundColorAttributeName,
                         value: Colors.mainColorUI,
                         range: NSRange(location:0, length:msg.length))
        
        
        return msg
        
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let text = "Start by adding a new patch with the + button ! ";
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center;
        
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 24),
                          NSForegroundColorAttributeName: UIColor.lightGray,
                          NSParagraphStyleAttributeName: paragraph]
        
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.white
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        
        return CGFloat(integerLiteral: 20)
    }
}
