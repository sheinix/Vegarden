//
//  CropDetailsFlowLayout.swift
//  Vegarden
//
//  Created by Sarah Cleland on 10/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class CropDetailsFlowLayout: UICollectionViewFlowLayout {

    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        
        let page = ceil(proposedContentOffset.x / (self.collectionView?.frame.size.width)!);
 
        return CGPoint(x:page * (self.collectionView?.frame.size.width)!, y:0);
    }
    
}
