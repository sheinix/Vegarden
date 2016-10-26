//
//  LifeCycleDetailiView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 25/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class LifeCycleDetailiView: UICollectionViewController {

   
    
    override func viewDidLoad() {
       
        super.viewDidLoad()

         self.collectionView!.register(DetailViewCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifiers.lifeCycleDetailViewCellIdentifier)
        
        self.view.backgroundColor = UIColor.red
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.lifeCycleDetailViewCellIdentifier, for: indexPath) as! DetailViewCollectionViewCell)
        
        cell.stageTitle.text = "HOLAAAAAAAA"
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }

}
extension LifeCycleDetailiView : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
    

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        //2
//        let paddingSpace = Int(sectionInsets.left) * (self.lifeCycle.count + 1)
//        let availableWidth = Int(view.frame.width) - paddingSpace
//        let widthPerItem = availableWidth / self.lifeCycle.count
//        
//        return CGSize(width: widthPerItem, height: widthPerItem)
//    }
    
    //3
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  insetForSectionAt section: Int) -> UIEdgeInsets {
//        
//        return sectionInsets
//    }
//    
//    // 4
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,  minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        
//        return sectionInsets.left
//    }
}
