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
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        WalkthroughManager.shared.initializeWalkthroughIn(viewController: self)
        WalkthroughManager.shared.delegate = self
        
//        let myGarden = self.
//        splitViewController.showDetailViewController(myGarden, sender: nil)
    }
    
    func didCloseWalkthrough() {
        self.dismiss(animated: true) {
            
            //self.showDetailViewController(<#T##vc: UIViewController##UIViewController#>, sender: nil)
        }
    }
    
    func didChangeWalkthroughPage(pageNumber: Int) {
        
    }
}


