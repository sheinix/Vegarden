//
//  VTransition.swift
//  Vegarden
//
//  Created by Sarah Cleland on 16/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import UIKit

let animationDuration = 0.35
let animationScale = screenWidth/gridWidth // screenWidth / the width of waterfall collection view's grid

class VTransition : NSObject , UIViewControllerAnimatedTransitioning{
    var presenting = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as UIViewController!
        
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as UIViewController!
        
        let containerView = transitionContext.containerView
        
        if presenting {
            
            let toView = toViewController?.view!
            containerView.addSubview(toView!)
            toView?.isHidden = true
            
            let waterFallView = (toViewController as! VTransitionProtocol).transitionCollectionView()
            let pageView = (fromViewController as! VTransitionProtocol).transitionCollectionView()
            waterFallView?.layoutIfNeeded()
            
            let indexPath = pageView?.fromPageIndexPath()
            var gridView = waterFallView?.cellForItem(at: indexPath as! IndexPath)
            
            //In case last item of collection was deleted, cellForItem returns nil, so i create a dummy cell to keep going...
            if (gridView == nil) {
                gridView = MyCropsCollectionViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            }
            
            let leftUpperPoint = gridView!.convert(CGPoint.zero, to: toViewController?.view)
            
            let snapShot = (gridView as! VTansitionWaterfallGridViewProtocol).snapShotForTransition()
           
            snapShot?.transform = CGAffineTransform(scaleX: animationScale, y: animationScale)
           
            let pullOffsetY = (fromViewController as! VHorizontalPageViewControllerProtocol).pageViewCellScrollViewContentOffset().y
            
            let offsetY : CGFloat = fromViewController!.navigationController!.isNavigationBarHidden ? 0.0 : navigationHeaderAndStatusbarHeight
            
            snapShot?.origin(point: CGPoint(x:0, y:-pullOffsetY+offsetY))
            containerView.addSubview(snapShot!)
            
            toView?.isHidden = false
            toView?.alpha = 0
            toView?.transform = (snapShot?.transform)!
            toView?.frame = CGRect(x:-((leftUpperPoint.x) * animationScale),y:-(((leftUpperPoint.y)-offsetY) * animationScale+pullOffsetY+offsetY),
                                   width:(toView?.frame.size.width)!, height:(toView?.frame.size.height)!)
            let whiteViewContainer = UIView(frame: screenBounds)
            whiteViewContainer.backgroundColor = UIColor.white
            containerView.addSubview(snapShot!)
            
            containerView.insertSubview(whiteViewContainer, belowSubview: toView!)
            
            UIView.animate(withDuration: animationDuration, animations: {
                
                snapShot?.transform = CGAffineTransform.identity
                snapShot?.frame = CGRect(x:(leftUpperPoint.x), y:(leftUpperPoint.y), width:(snapShot?.frame.size.width)!, height:(snapShot?.frame.size.height)!)
                toView?.transform = CGAffineTransform.identity
                toView?.frame = CGRect(x:0, y:0, width:(toView?.frame.size.width)!, height:(toView?.frame.size.height)!);
                toView?.alpha = 1
                }, completion:{finished in
                    if finished {
                        snapShot?.removeFromSuperview()
                        whiteViewContainer.removeFromSuperview()
                        transitionContext.completeTransition(true)
                    }
            })
        }else {
            let fromView = fromViewController?.view
            let toView = toViewController?.view
            
            let waterFallView : UICollectionView = (fromViewController as! VTransitionProtocol).transitionCollectionView()
            
            let pageView : UICollectionView = (toViewController as! VTransitionProtocol).transitionCollectionView()
            
            containerView.addSubview(fromView!)
            containerView.addSubview(toView!)
            
            let indexPath = waterFallView.toIndexPath()
            let gridView = waterFallView.cellForItem(at: indexPath as IndexPath)
            
            let leftUpperPoint = gridView!.convert(CGPoint.zero, to: nil)
            pageView.isHidden = true
            pageView.scrollToItem(at: indexPath as IndexPath, at:.centeredHorizontally, animated: false)
            
            let offsetY : CGFloat = fromViewController!.navigationController!.isNavigationBarHidden ? 0.0 : navigationHeaderAndStatusbarHeight
            let offsetStatuBar : CGFloat = fromViewController!.navigationController!.isNavigationBarHidden ? 0.0 :
            statubarHeight;
            let snapShot = (gridView as! VTansitionWaterfallGridViewProtocol).snapShotForTransition()
            containerView.addSubview(snapShot!)
            snapShot?.origin(point: leftUpperPoint)
            UIView.animate(withDuration: animationDuration, animations: {
                snapShot?.transform = CGAffineTransform(scaleX: animationScale,
                                                       y: animationScale)
                snapShot?.frame = CGRect(x:0, y:offsetY, width:(snapShot?.frame.size.width)!, height:(snapShot?.frame.size.height)!)
                
                fromView?.alpha = 0
                fromView?.transform = (snapShot?.transform)!
                fromView?.frame = CGRect(x:-(leftUpperPoint.x)*animationScale,
                                         y:-(leftUpperPoint.y-offsetStatuBar)*animationScale+offsetStatuBar,
                                         width:(fromView?.frame.size.width)!,
                                         height:(fromView?.frame.size.height)!)
                },completion:{finished in
                    if finished {
                        snapShot?.removeFromSuperview()
                        pageView.isHidden = false
                        fromView?.transform = CGAffineTransform.identity
                        transitionContext.completeTransition(true)
                    }
            })
        }
    }
}

