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
    var fromDatabase : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationController?.navigationBar.isHidden = true
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
    
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let collectionCell: VCropDetailPageViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.CropDetailViewCellIdentify, for: indexPath) as! VCropDetailPageViewCell
    
    
        collectionCell.delegate = self
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
        
        guard let cropDetailCell = cell as? VCropDetailPageViewCell else { return }
        
        if cropDetailCell.crop !== self.cropList[indexPath.row]  {
            
            //print("We have a problem! Ouch!!!")
        }
        
        let animationPoint = CGPoint(x: (cropDetailCell.contentView.frame.width/2)-250,
                                     y:(cropDetailCell.frame.size.height/2)-250)
        
        InstructionsManager.shared.animate(gesture: .swipeDown,
                                                in: animationPoint,
                                                of: cropDetailCell.contentView)
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
//         guard let cropDetailCell = cell as? VCropDetailPageViewCell else { return }
//        
//         cropDetailCell.crop?.removeObserver(cropDetailCell, forKeyPath: "owned", context: &cropDetailCell.myContext)
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
}
    

extension CropDetailCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemSize: CGSize?
        let navBarHidden = self.navigationController?.isNavigationBarHidden
        let size = self.collectionView?.frame.size
        
        
        
        if ((size?.width)! > (size?.height)!) { //landscape
            
            itemSize = CGSize(width: (size?.width)!, height: (navBarHidden! ? screenHeight+20 : screenHeight-navigationHeaderAndStatusbarHeight))
        
        } else {
            
            itemSize = (navBarHidden! ? CGSize(width:screenWidth, height:collectionView.frame.size.height) :
                                       CGSize(width:screenWidth, height:collectionView.frame.size.height/*screenHeight-navigationHeaderAndStatusbarHeight*/))
        }

        return itemSize!
    }
}
extension CropDetailCollectionViewController : RemoveCropButtonDelegate {
    
    func didPressRemoveCropBttn(crop: Crop) {
        
//        guard (GardenManager.shared.myPlantedCrops()?.filter { $0.name == crop.name } != nil) else {
        
            GardenManager.shared.removeCropFromGarden(crop: crop)
//            return
//        }
        
//        self.showAlertView(title: "Wait!",
//                            message: "This crop is still planted. Please Unplant it from the LifeCycle screen first!",
//                               style: .alert,
//                        confirmBlock: {},
//                         cancelBlock: {})
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
