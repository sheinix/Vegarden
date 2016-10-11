//
//  MyCropsCollectionViewController.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 10/9/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import AVFoundation
//import LiquidFloatingActionButton
import KCFloatingActionButton


private let reuseIdentifier = "MyCropCell"

class MyCropsCollectionViewController: UICollectionViewController {

    var myCrops = CropVeggie.allPhotos()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.register(MyCropsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.automaticallyAdjustsScrollViewInsets = true;
        
        // set the pinterest layout
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }

        //MARK - Floating Button
        
        setupFloatingBttn()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

// MARK: PinterestLayoutDelegate
extension MyCropsCollectionViewController : PinterestLayoutDelegate {
    
    // 1. Returns the photo height
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath , withWidth width:CGFloat) -> CGFloat {
        
        let crop = myCrops[indexPath.item]
        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect  = AVMakeRect(aspectRatio: crop.image.size, insideRect: boundingRect)
        return rect.size.height
    }
    
    // 2. Returns the annotation size based on the text
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        
        let annotationPadding = CGFloat(4)
        let annotationHeaderHeight = CGFloat(17)
        
        let crop = myCrops[indexPath.item]
        let font = UIFont(name: "AvenirNext-Regular", size: 10)!
        let commentHeight = crop.heightForComment(font: font, width: width)
        let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
        
        return height
    }
}

// MARK: LiquidFloatingActionButtonDelegate
//extension MyCropsCollectionViewController : LiquidFloatingActionButtonDelegate, LiquidFloatingActionButtonDataSource {
//    
//    func numberOfCells(_ liquidFloatingActionButton: LiquidFloatingActionButton) -> Int {
//        return 3
//    }
//    
//    func cellForIndex(_ index: Int) -> LiquidFloatingCell {
//        
//        return LiquidFloatingCell(icon: UIImage(named: "crops")!)
//        
//    }
//    
//    
//    func liquidFloatingActionButton(_ liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int) {
//        
//        
//        print("print item at index: /index")
//    }
//}
