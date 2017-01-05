//
//  UISplitViewControllerExtension.swift
//  Vegarden
//
//  Created by Sarah Cleland on 22/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import UIKit


extension UISplitViewController : WalkthroughDelegate {
    
     var seguePerformer : UIViewController  {
        
        return (self.viewControllers[self.viewControllers.count-1] as! UINavigationController).topViewController!
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        WalkthroughManager.shared.delegate = self
        WalkthroughManager.shared.initializeWalkthroughIn(viewController: self)
        

    }
    
    func walkthroughDidFinishEarly() {
       
        self.seguePerformer.performSegue(withIdentifier: "showMyGardenView" , sender:self)
       
    }
    
    func didCloseWalkthrough() {
        self.dismiss(animated: false) {
            
        }
    }
    
    func didChangeWalkthroughPage(pageNumber: Int) {
        
    }
}


