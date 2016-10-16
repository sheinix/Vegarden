//
//  VTransitionProtocol.swift
//  Vegarden
//
//  Created by Sarah Cleland on 16/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import UIKit

@objc protocol VTransitionProtocol{
    func transitionCollectionView() -> UICollectionView!
}

@objc protocol VTansitionWaterfallGridViewProtocol{
    func snapShotForTransition() -> UIView!
}

@objc protocol VWaterFallViewControllerProtocol : VTransitionProtocol{
    func viewWillAppearWithPageIndex(pageIndex : NSInteger)
}

@objc protocol VHorizontalPageViewControllerProtocol : VTransitionProtocol{
    func pageViewCellScrollViewContentOffset() -> CGPoint
}
