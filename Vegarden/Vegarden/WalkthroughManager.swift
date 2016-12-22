//
//  WalkthroughManager.swift
//  Vegarden
//
//  Created by Sarah Cleland on 22/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import BWWalkthrough

protocol WalkthroughDelegate: class {
    
    func didCloseWalkthrough()
    
    func didChangeWalkthroughPage(pageNumber: Int)
    
}


private let sharedWalkthroughManager = WalkthroughManager()

class WalkthroughManager {
    
    class var shared: WalkthroughManager {
        
        return sharedWalkthroughManager
    }
    
    weak var delegate: WalkthroughDelegate?
    
    var walkThrough : MasterWalkthroughViewController?
    
    public func initializeWalkthroughIn(viewController: UIViewController) {
        
        if !UserDefaults.standard.bool(forKey: "walkthroughPresented") {
            
            showWalkthroughIn(viewController: viewController)
      //TODO Change it for production!
     //       UserDefaults.standard.set(true, forKey: "walkthroughPresented")
            UserDefaults.standard.synchronize()
        }
    }
    
    func showWalkthroughIn(viewController: UIViewController) {
        
        // Get view controllers and build the walkthrough
        let stb         = UIStoryboard(name: "Walkthrough", bundle: nil)
        
        self.walkThrough =   stb.instantiateViewController(withIdentifier: "Master") as? MasterWalkthroughViewController
        
        let pageOne    = stb.instantiateViewController(withIdentifier:"page1") as UIViewController
        let pageTwo    = stb.instantiateViewController(withIdentifier:"page2") as UIViewController
        let pageThree  = stb.instantiateViewController(withIdentifier:"page3") as UIViewController
        
        // Attach the pages to the master

        walkThrough?.delegate = self
        walkThrough?.add(viewController:pageOne)
        walkThrough?.add(viewController:pageTwo)
        walkThrough?.add(viewController:pageThree)
        
        viewController.present(walkThrough!, animated: true, completion: nil)
        
    }
    
}
extension WalkthroughManager : BWWalkthroughViewControllerDelegate {
    
    func walkthroughCloseButtonPressed() {
    
        delegate?.didCloseWalkthrough()
    }
    
    func walkthroughPageDidChange(_ pageNumber: Int) {
        
        let isLastStep = ((self.walkThrough?.numberOfPages)! - 1 == pageNumber)
        
        self.walkThrough?.closeButton?.isHidden = !isLastStep
        self.walkThrough?.hiddenFinishBttn      = !isLastStep
        self.walkThrough?.nextButton?.isHidden  = (pageNumber != 0)
        self.walkThrough?.hiddenCreatePatchBttn = (pageNumber != 1)
        
        delegate?.didChangeWalkthroughPage(pageNumber: pageNumber)
    }
}
