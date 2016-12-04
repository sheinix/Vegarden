//
//  Macros.swift
//  Vegarden
//
//  Created by Sarah Cleland on 4/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation

    
    public func getCropDetailCollectionViewFlowLayoutIn (navigationController navController:UINavigationController) -> UICollectionViewFlowLayout {
        
        let flowLayout = CropDetailsFlowLayout()
        
        var itemSize : CGSize?
        
        itemSize = navController.isNavigationBarHidden ?
            CGSize(width:screenWidth, height:screenHeight+20) : CGSize(width:screenWidth, height:screenHeight-navigationHeaderAndStatusbarHeight)
        
        
        flowLayout.itemSize = itemSize!
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 5,left: 0,bottom: 5,right: 0)
        
        return flowLayout
}
    
