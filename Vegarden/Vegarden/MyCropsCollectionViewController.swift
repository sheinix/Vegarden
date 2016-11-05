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

private let reuseIdentifier = "MyCropCell"

class MyCropsCollectionViewController: UICollectionViewController {

    var myCrops = GardenManager.shared.allCrops()
    let delegateHolder = ZoomInNavigationController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
        self.navigationController!.delegate = delegateHolder
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.automaticallyAdjustsScrollViewInsets = true;
        
        //CHTCollectionViewWaterfall lyout:
        (self.collectionView?.collectionViewLayout as! CHTCollectionViewWaterfallLayout).columnCount = 2
        
        setupFloatingBttn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupFloatingBttn() {

        let fab = KCFloatingActionButton()
        fab.openAnimationType = KCFABOpenAnimationType.pop
        fab.openingAnimationDirection = KCFABOpeningAnimationDirection.Vertical
        
        fab.addItem("Add Crop", icon: UIImage(named: "crops")!, handler: { item in
           
            let popOver = PopupCustomView.getAddCropTableViewPop()
            popOver.delegate = self
            popOver.show()
            fab.close()
        })
        
        
        view.addSubview(fab)
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return myCrops.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCropsCollectionViewCell

        cell.crop = myCrops[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        let layout = HelperManager.getCropDetailCollectionViewFlowLayoutIn(navigationController: self.navigationController!)
        let pageDetailViewController =
            CropDetailCollectionViewController(collectionViewLayout: layout, currentIndexPath:indexPath as NSIndexPath)
        
        pageDetailViewController.cropList = myCrops
        collectionView.setToIndexPath(indexPath: indexPath as NSIndexPath)
        navigationController!.pushViewController(pageDetailViewController, animated: true)
    }
    
    // MARK: UICollectionViewDelegate
 
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

}

// MARK: CHTCollectionViewWaterfallLayoutDelegate
extension MyCropsCollectionViewController : CHTCollectionViewDelegateWaterfallLayout {
  
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAt indexPath: IndexPath!) -> CGSize {
                
        let image = UIImage(named:self.myCrops[indexPath.row].picture!)
        
        return CGSize(width: (image!.size.width), height: (image!.size.height))
    }

    
}

extension MyCropsCollectionViewController : VTransitionProtocol, VWaterFallViewControllerProtocol {
    
    func viewWillAppearWithPageIndex(pageIndex : NSInteger) {
        
        var position : UICollectionViewScrollPosition =
            UICollectionViewScrollPosition.centeredHorizontally.intersection(.centeredVertically)
      
        let image =  UIImage(named:self.myCrops[pageIndex].picture!)
        
        let imageHeight = (image?.size.height)!*gridWidth/(image?.size.width)!
        
        if imageHeight > 400 {//whatever you like, it's the max value for height of image
            position = .top
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

extension MyCropsCollectionViewController: PopupDelegate {
    
    func popupDidAppear(_ popup: Popup!) {
        
    }
    
    func popupPressButton(_ popup: Popup!, buttonType: PopupButtonType) {
        
    }
}
