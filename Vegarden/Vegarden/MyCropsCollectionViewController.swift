//
//  MyCropsCollectionViewController.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 10/9/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import AVFoundation
import KCFloatingActionButton
import CHTCollectionViewWaterfallLayout
import SnapKit
import DZNEmptyDataSet

private let reuseIdentifier = "MyCropCell"

class MyCropsCollectionViewController: UICollectionViewController {
    
    var isDataBase : Bool = true
    var myCrops    : [Crop]? = []//

    let delegateHolder = ZoomInNavigationController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        myCrops = (isDataBase ? GardenManager.shared.unowedCrops() : GardenManager.shared.myCrops())
        
        self.clearsSelectionOnViewWillAppear = false
        self.navigationController!.delegate = delegateHolder
        self.navigationController?.navigationBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = true;
        
        self.collectionView?.emptyDataSetSource = self
        self.collectionView?.emptyDataSetDelegate = self
        
        //CHTCollectionViewWaterfall lyout:
        (self.collectionView?.collectionViewLayout as! CHTCollectionViewWaterfallLayout).columnCount = 2
        
        self.addObserversForCropActions()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addObserversForCropActions() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshCollection),
                                               name: NSNotification.Name(rawValue: NotificationIds.NotiKeyCropRemoved),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshCollection),
                                               name: NSNotification.Name(rawValue: NotificationIds.NotiKeyCropAdded),
                                               object: nil)
        
        
    }
    
    @objc private func refreshCollection(notification: Notification) {
        
        if let collection = self.collectionView {
            
            let crop = (notification.userInfo?["crop"] as! Crop)
            
            if let row = self.myCrops?.index(of:crop) {
                
                let idx =  IndexPath(row: row, section: 0)
                
                    self.myCrops?.remove(at: row)
                    collection.deleteItems(at: [idx])
                    collection.reloadData()
            }
        }
    }
}

// MARK: UICollectionViewDataSource / Delegate

extension MyCropsCollectionViewController {
    
  
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return myCrops!.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCropsCollectionViewCell
        
        let crop = myCrops?[indexPath.row]
        
        cell.crop = crop
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let layout = getCropDetailCollectionViewFlowLayoutIn(navigationController: self.navigationController!)
        let pageDetailViewController =
            CropDetailCollectionViewController(collectionViewLayout: layout, currentIndexPath:indexPath as NSIndexPath)
        
        
        pageDetailViewController.cropList = myCrops!
        collectionView.setToIndexPath(indexPath: indexPath as NSIndexPath)
        navigationController!.pushViewController(pageDetailViewController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: CHTCollectionViewWaterfallLayoutDelegate
extension MyCropsCollectionViewController : CHTCollectionViewDelegateWaterfallLayout {
  
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAt indexPath: IndexPath!) -> CGSize {
        
        let stringImg = self.myCrops?[indexPath.row].picture
        
        let image = UIImage(named:stringImg!)
        
     //   ((indexPath.row % 2) == 0 ? image!.size.height : image!.size.height * 1.3)
        
        return CGSize(width: (image!.size.width), height: (image!.size.height))
    }

}

extension MyCropsCollectionViewController : VTransitionProtocol, VWaterFallViewControllerProtocol {
    
    func viewWillAppearWithPageIndex(pageIndex : NSInteger) {
        
        var position : UICollectionViewScrollPosition =
            UICollectionViewScrollPosition.centeredHorizontally.intersection(.centeredVertically)
        
        //if something was deleted not scrolling back to position because it isnt there..
        guard ((self.myCrops?.count)! > pageIndex) else {
            return
        }
        
        
        if let imgName = self.myCrops?[pageIndex].picture {
           
            let image =  UIImage(named:imgName)
            
            let imageHeight = (image?.size.height)!*gridWidth/(image?.size.width)!
            
            if imageHeight > 200 {//whatever you like, it's the max value for height of image
                position = .top
            }
        }
        
        
        let currentIndexPath = NSIndexPath(row: pageIndex, section: 0)
        let collectionView = self.collectionView!;
        collectionView.setToIndexPath(indexPath: currentIndexPath)
        if pageIndex<2{
            collectionView.setContentOffset(CGPoint.zero, animated: false)
            
        }else{
            
            collectionView.scrollToItem(at: currentIndexPath as IndexPath, at: position, animated: false)
        }
    }
    
    func transitionCollectionView() -> UICollectionView!{
        return collectionView
    }
}

extension MyCropsCollectionViewController : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        
        return (UIImage(named: "NoCropsInMyCrops"))
        
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        
        let msg = NSMutableAttributedString(string: "Oops! No Crops Added yet!",
                                            attributes: [NSFontAttributeName:Fonts.emptyStateFont])
        msg.addAttribute(NSForegroundColorAttributeName,
                         value: Colors.mainColorUI,
                         range: NSRange(location:0, length:msg.length))
        
        
        return msg
        
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let text = "Choose the Crops you want to have from the Database and add them to your Crops to start planting them ! ";
        
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
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
