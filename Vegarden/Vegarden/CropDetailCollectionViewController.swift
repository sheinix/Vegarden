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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
//        self.navigationController?.navigationBar.backItem?.backBarButtonItem?
        self.view.layer.cornerRadius = 10
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    init(collectionViewLayout layout: UICollectionViewLayout!, currentIndexPath indexPath: NSIndexPath){
        
        super.init(collectionViewLayout:layout)
        
        let collectionView :UICollectionView = self.collectionView!;
        collectionView.isPagingEnabled = true
        collectionView.register(VCropDetailPageViewCell.self, forCellWithReuseIdentifier: CellIdentifiers.CropDetailViewCellIdentify)
        
        collectionView.setToIndexPath(indexPath: indexPath)
        collectionView.performBatchUpdates({collectionView.reloadData()}, completion: { finished in
         
            if finished {
                collectionView.scrollToItem(at: indexPath as IndexPath,at:.centeredHorizontally, animated: false)
            }});
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        
//        super.viewWillTransition(to: size, with: coordinator)
//        
//        updateCollectionViewLayout(with: size)
//    }
//    
//    private func updateCollectionViewLayout(with: CGSize) {
//        
//        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
//            
//            layout.itemSize = screenSize //(size.width < size.height) ? screenSize : screenSize)
//           
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
            self.navigationController!.popViewController(animated: true)
        }
        collectionCell.setNeedsLayout()
    
        return collectionCell
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

extension CropDetailCollectionViewController: VTransitionProtocol, VHorizontalPageViewControllerProtocol {
    
    func transitionCollectionView() -> UICollectionView!{
        return collectionView
    }
    
    func pageViewCellScrollViewContentOffset() -> CGPoint{
        return self.pullOffset
    }
}
