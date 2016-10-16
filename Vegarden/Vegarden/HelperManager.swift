//
//  HelperManager.swift
//  Vegarden
//
//  Created by Sarah Cleland on 16/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation


public class HelperManager {
    
    public class func getCropDetailCollectionViewFlowLayoutIn (navigationController navController:UINavigationController) -> UICollectionViewFlowLayout {
        
        let flowLayout = UICollectionViewFlowLayout()
        let itemSize  = navController.isNavigationBarHidden ?
            CGSize(width:screenWidth, height:screenHeight+20) : CGSize(width:screenWidth, height:screenHeight-navigationHeaderAndStatusbarHeight)
        
        flowLayout.itemSize = itemSize
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        return flowLayout
    }
}

