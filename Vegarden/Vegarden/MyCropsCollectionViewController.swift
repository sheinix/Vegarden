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

private let reuseIdentifier = "MyCropCell"

class MyCropsCollectionViewController: UICollectionViewController {

    var myCrops = CropVeggie.allPhotos()
    let delegateHolder = ZoomInNavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        self.navigationController!.delegate = delegateHolder
        (self.collectionView?.collectionViewLayout as! CHTCollectionViewWaterfallLayout).columnCount = 2
        
        // Register cell classes
       // self.collectionView!.register(MyCropsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.automaticallyAdjustsScrollViewInsets = true;
        
        // set the pinterest layout
//        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
//            layout.delegate = self
//        }

        //MARK - Floating Button
        setupFloatingBttn()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// Set a layout for the detailview:
    
    func pageDetailViewControllerLayout () -> UICollectionViewFlowLayout {
        
        let flowLayout = UICollectionViewFlowLayout()
        let itemSize  = self.navigationController!.isNavigationBarHidden ?
            CGSize(width:screenWidth, height:screenHeight+20) : CGSize(width:screenWidth, height:screenHeight-navigationHeaderAndStatusbarHeight)
        
        flowLayout.itemSize = itemSize
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        return flowLayout
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    
    func setupFloatingBttn() {
        
        let bttnFrame = CGRect(origin: CGPoint(x: view.frame.size.width - UINumbericConstants.floatingBttnSize,y :view.frame.size.height - UINumbericConstants.floatingBttnSize), size: UINumbericConstants.floattingBttnCGSize)
       
        let fab = KCFloatingActionButton()
        fab.frame = bttnFrame
        fab.addItem("Add Crop", icon: UIImage(named: "crops")!, handler: { item in
            let alert = UIAlertController(title: "Hey", message: "Implement AddCrop!...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok men!", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
      
        let pageDetailViewController =
            CropDetailCollectionViewController(collectionViewLayout: pageDetailViewControllerLayout(), currentIndexPath:indexPath as NSIndexPath)
        
        pageDetailViewController.cropList = myCrops
        collectionView.setToIndexPath(indexPath: indexPath as NSIndexPath)
        navigationController!.pushViewController(pageDetailViewController, animated: true)
    }
    
    // MARK: UICollectionViewDelegate
 
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    */

}

// MARK: CHTCollectionViewWaterfallLayoutDelegate
extension MyCropsCollectionViewController : CHTCollectionViewDelegateWaterfallLayout {
    /**
     *  Asks the delegate for the size of the specified item’s cell.
     *
     *  @param collectionView
     *    The collection view object displaying the waterfall layout.
     *  @param collectionViewLayout
     *    The layout object requesting the information.
     *  @param indexPath
     *    The index path of the item.
     *
     *  @return
     *    The original size of the specified item. Both width and height must be greater than 0.
     */
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAt indexPath: IndexPath!) -> CGSize {
                
        let image = self.myCrops[indexPath.row].image
        
        return CGSize(width: (image.size.width), height: (image.size.height))
    }

    
}

extension MyCropsCollectionViewController : VTransitionProtocol, VWaterFallViewControllerProtocol {
    
    func viewWillAppearWithPageIndex(pageIndex : NSInteger) {
        
        var position : UICollectionViewScrollPosition =
            UICollectionViewScrollPosition.centeredHorizontally.intersection(.centeredVertically)
      
        let image =  self.myCrops[pageIndex].image
        
        let imageHeight = image.size.height*gridWidth/image.size.width
        
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
