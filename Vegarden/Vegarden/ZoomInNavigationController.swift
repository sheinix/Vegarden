//
//  ZoomInNavigationController.swift
//  Vegarden
//
//  Created by Sarah Cleland on 11/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class ZoomInNavigationController: UINavigationController {

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.delegate = self;
        self.navigationBar.isTranslucent = true
        self.navigationBar.backgroundColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func popViewController(animated: Bool) -> UIViewController {
        
        //viewWillAppearWithPageIndex
        let childrenCount = self.viewControllers.count
        let toViewController = self.viewControllers[childrenCount-2] as! VWaterFallViewControllerProtocol
        let toView = toViewController.transitionCollectionView()
        let popedViewController = self.viewControllers[childrenCount-1] as! UICollectionViewController
        let popView  = popedViewController.collectionView!;
        let indexPath = popView.fromPageIndexPath()
       
        toViewController.viewWillAppearWithPageIndex(pageIndex: indexPath.row)
        toView?.setToIndexPath(indexPath: indexPath)
        
        return super.popViewController(animated: animated)!
    }
}

extension ZoomInNavigationController : UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let fromVCConfromA = (fromVC as? VTransitionProtocol)
        let fromVCConfromB = (fromVC as? VWaterFallViewControllerProtocol)
        let fromVCConfromC = (fromVC as? VHorizontalPageViewControllerProtocol)
        
        let toVCConfromA = (toVC as? VTransitionProtocol)
        let toVCConfromB = (toVC as? VWaterFallViewControllerProtocol)
        let toVCConfromC = (toVC as? VHorizontalPageViewControllerProtocol)
        
        if((fromVCConfromA != nil)&&(toVCConfromA != nil)&&(
            (fromVCConfromB != nil && toVCConfromC != nil)||(fromVCConfromC != nil && toVCConfromB != nil))){
            
            let transition = VTransition()
            transition.presenting = operation == .pop
            return  transition
        }else{
            return nil
        }
        
    }
}
