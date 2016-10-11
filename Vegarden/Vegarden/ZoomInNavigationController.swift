//
//  ZoomInNavigationController.swift
//  Vegarden
//
//  Created by Sarah Cleland on 11/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import RMPZoomTransitionAnimator

class ZoomInNavigationController: UINavigationController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.delegate = self;
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

}

extension ZoomInNavigationController : UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // minimum implementation for example
        let animator = RMPZoomTransitionAnimator()
        animator.goingForward = (operation == UINavigationControllerOperation.push);
        animator.sourceTransition = (fromVC as? RMPZoomTransitionAnimating as! (RMPZoomTransitionAnimating & RMPZoomTransitionDelegate)!)
        animator.destinationTransition = (toVC as? RMPZoomTransitionAnimating as! (RMPZoomTransitionAnimating & RMPZoomTransitionDelegate)!)
        
        return animator;
        
    }
}
