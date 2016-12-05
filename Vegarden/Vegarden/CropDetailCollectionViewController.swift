//
//  CropDetailCollectionViewController.swift
//  Vegarden
//
//  Created by Sarah Cleland on 16/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CropDetailCollectionViewController: UICollectionViewController {

    var pullOffset = CGPoint.zero
    var cropList: Array <Crop> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0)

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init(collectionViewLayout layout: UICollectionViewLayout!, currentIndexPath indexPath: NSIndexPath){
        
        super.init(collectionViewLayout:layout)
        
        let collectionView : UICollectionView = self.collectionView!;
        collectionView.isPagingEnabled = true
        collectionView.register(VCropDetailPageViewCell.self, forCellWithReuseIdentifier: CellIdentifiers.CropDetailViewCellIdentify)
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.setToIndexPath(indexPath: indexPath)
        collectionView.performBatchUpdates({collectionView.reloadData()}, completion: { finished in
         
            if finished {
                collectionView.scrollToItem(at: indexPath as IndexPath,at:.centeredHorizontally, animated: false)
            }});
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
//        let offset = self.collectionView?.contentOffset
//        let width  = self.collectionView?.bounds.size.width
//        
//        let index     = round(offset!.x / width!);
//        let newOffset = CGPoint(x:index * size.width, y:offset!.y);
//        
//        self.collectionView?.setContentOffset(newOffset, animated: false)
        if let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout()
        }
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            
           

//
//            self.collectionView?.reloadData()
//
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            

             //self.collectionView?.setContentOffset(newOffset, animated: false)
        })
    
        super.viewWillTransition(to: size, with: coordinator)
    }
//
//    override func viewWillLayoutSubviews() {
//        
//        super.viewWillLayoutSubviews()
//        
//        if let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.invalidateLayout()
//        }
//    }
    
    
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let collectionCell: VCropDetailPageViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.CropDetailViewCellIdentify, for: indexPath) as! VCropDetailPageViewCell
    
        collectionCell.crop = self.cropList[indexPath.row]
        collectionCell.image = UIImage(named:self.cropList[indexPath.row].picture!)
        collectionCell.cropTitle.text = self.cropList[indexPath.row].name
        collectionCell.tappedAction = {}
        collectionCell.pullAction = { offset in
            self.pullOffset = offset
            
            if let nav = self.navigationController {
                    nav.popViewController(animated: true)
            } else {
                self.removeFromParentViewController()
            }
            
        }
        collectionCell.setNeedsLayout()
    
        return collectionCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (cell as! VCropDetailPageViewCell).crop !== self.cropList[indexPath.row]  {
            
            print("We have a problem! Ouch!!!")
        }
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return cropList.count;
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        NotificationCenter.default.removeObserver(cell)
    }
    
//    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        
//        if let collectionView = collectionView {
//            
//            targetContentOffset.pointee = scrollView.contentOffset
//            let pageWidth = scrollView.frame.width + (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing
//            
//            var assistanceOffset : CGFloat = pageWidth / 3.0
//            
//            if velocity.x < 0 {
//                assistanceOffset = -assistanceOffset
//            }
//            
//            let assistedScrollPosition = (scrollView.contentOffset.x + assistanceOffset) / pageWidth
//            
//            var targetIndex = Int(round(assistedScrollPosition))
//            
//            
//            if targetIndex < 0 {
//                targetIndex = 0
//            }
//            else if targetIndex >= collectionView.numberOfItems(inSection: 0) {
//                targetIndex = collectionView.numberOfItems(inSection: 0) - 1
//            }
//            
//            print("targetIndex = \(targetIndex)")
//            
//            let indexPath = IndexPath(item: targetIndex, section: 0)
//            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
//            
//        }
//    }
}

extension CropDetailCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemSize: CGSize?
        let navBarHidden = self.navigationController?.isNavigationBarHidden
        let size = self.collectionView?.frame.size
        
        if ((size?.width)! > (size?.height)!) { //landscape
            
            itemSize = CGSize(width: (size?.width)!, height: (navBarHidden! ? screenHeight+20 : screenHeight-navigationHeaderAndStatusbarHeight))
        
        } else {
        
            itemSize = (navBarHidden! ? CGSize(width:screenWidth, height:screenHeight+20) :
                                       CGSize(width:screenWidth, height:screenHeight-navigationHeaderAndStatusbarHeight))
        }

        return itemSize!
    }
}

extension CropDetailCollectionViewController: VTransitionProtocol, VHorizontalPageViewControllerProtocol {
    
    func transitionCollectionView() -> UICollectionView!{
        return collectionView
    }
    
    func pageViewCellScrollViewContentOffset() -> CGPoint{
        return self.pullOffset
    }
}
