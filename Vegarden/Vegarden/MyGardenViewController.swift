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

let rowsMaxHeight = screenHeight/2
let headerHeight = 80

class MyGardenViewController: UITableViewController, TableHeaderAddButtonProtocol {

    let totalPlantedCrops : Int = (GardenManager.shared.myPlantedCrops()?.count)!
    var totalPaddocks : Int = (GardenManager.shared.getMyGarden().paddocks?.count)!
    var patchs : [Paddock] = (GardenManager.shared.getMyGarden().paddocks?.allObjects as! [Paddock])
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
 
    @objc fileprivate func newPatchAdded(notification: NSNotification) {
        
        if let patch = notification.userInfo?["patch"] as? Paddock {
            
            self.patchs.append(patch)
            self.totalPaddocks += 1
            
            if let cell = self.tableView.cellForRow(at: IndexPath(row:0, section:1)) as?  MyGardenDetailTableViewCell {
                
                if let myCV = cell.myGardenCollectionView {
                    
                    let header = (self.tableView(self.tableView, viewForHeaderInSection: 1) as! MyGardenTableSectionHeaderView)
                    
                    DispatchQueue.main.async {
                        header.titleLabel.text = "My Garden | Number of Patchs : " + String(self.totalPaddocks)
                    }
                    myCV.reloadData()
                }
            }
        }

        
    }
    
    @objc fileprivate func patchDeleted(notification: NSNotification) {
        
        if let patch = notification.userInfo?["patch"] as? Paddock {
            
            let idx = self.patchs.index(of: patch)
            self.patchs.remove(at: idx!)
            self.totalPaddocks -= 1
            
            if let cell = self.tableView.cellForRow(at: IndexPath(row:0, section:1)) as?  MyGardenDetailTableViewCell {
                
                if let myCV = cell.myGardenCollectionView {
                
                    myCV.deleteItems(at: [IndexPath(row: idx!, section: 0)])
                    let header = (self.tableView(self.tableView, viewForHeaderInSection: 1) as! MyGardenTableSectionHeaderView)
                    DispatchQueue.main.async {
                        header.titleLabel.text = "My Garden | Number of Patchs : " + String(self.totalPaddocks)
                    }
                }
            }
        }
    }
    
   @objc fileprivate func patchRowEdited(notification: NSNotification) {
    
        if let cell = self.tableView.cellForRow(at: IndexPath(row:0, section:1)) as?  MyGardenDetailTableViewCell {
        
            
            
            
            
            if let myCV = cell.myGardenCollectionView {
            
                DispatchQueue.main.async { myCV.reloadData() }
                
            }
        }
    
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
               // collection.reloadData()
            }
            
        }
        

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = MyGardenTableSectionHeaderView(frame: CGRect(x: 2, y: 0, width: Int(screenWidth)-2, height: headerHeight))
        
        let title = (section == 0 ? "Overview  |  Planted Crops : " + String(totalPlantedCrops) : "My Garden | Number of Patchs : " + String(totalPaddocks))
        
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
        
        //Set a minimum height if it doesnt have any rows:
        let realHeight = (self.rowsHeight! > CGFloat(integerLiteral: cropRowHeight) ?
            self.rowsHeight : 250)
        
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
extension MyGardenViewController : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        
        return (UIImage(named: "NoAvailablePaddocks"))
        
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        
        let msg = NSMutableAttributedString(string: "Oops! No Available Patchs!",
                                            attributes: [NSFontAttributeName:Fonts.emptyStateFont])
        msg.addAttribute(NSForegroundColorAttributeName,
                         value: Colors.mainColorUI,
                         range: NSRange(location:0, length:msg.length))
        
        
        return msg
        
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let text = "Start by adding a new patch with the plus button ! ";
        
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
