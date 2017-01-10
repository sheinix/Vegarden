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
    
    func walkthroughDidFinishEarly()
    
}


private let sharedWalkthroughManager = WalkthroughManager()

class WalkthroughManager {
    
    class var shared: WalkthroughManager {
        
        return sharedWalkthroughManager
    }
    
    weak var delegate: WalkthroughDelegate?
    
    var walkThrough : MasterWalkthroughViewController?
    
    public func initializeWalkthroughIn(viewController: UIViewController) {
        
        if !UserDefaults.standard.bool(forKey: UserDefaultsKeys.walkthroughKey) {
            
            showWalkthroughIn(viewController: viewController)

            UserDefaults.standard.set(true, forKey: UserDefaultsKeys.walkthroughKey)
            UserDefaults.standard.synchronize()
        
        } else {
            //Not the first time!
            delegate?.walkthroughDidFinishEarly()
        }
    }
    
    func showWalkthroughIn(viewController: UIViewController) {
        
        // Get view controllers and build the walkthrough
        let stb         = UIStoryboard(name: "Walkthrough", bundle: nil)
        
        self.walkThrough =   stb.instantiateViewController(withIdentifier: "Master") as? MasterWalkthroughViewController
        
        let welcomePage   = stb.instantiateViewController(withIdentifier:"page1") as UIViewController
        let patchPage     = stb.instantiateViewController(withIdentifier:"page2") as UIViewController
        let featuresPage  = stb.instantiateViewController(withIdentifier:"page23") as UIViewController
        let lastStepPage  = stb.instantiateViewController(withIdentifier:"page3") as UIViewController
        
        // Attach the pages to the master
        
       // walkThrough?.closeButton?.isHidden = true
        
        walkThrough?.delegate = self
        walkThrough?.add(viewController:welcomePage)
        walkThrough?.add(viewController:patchPage)
        walkThrough?.add(viewController:featuresPage)
        walkThrough?.add(viewController:lastStepPage)
        
        viewController.present(walkThrough!, animated: true, completion: nil)
        
    }
    
}
extension WalkthroughManager : BWWalkthroughViewControllerDelegate {
    
    func walkthroughCloseButtonPressed() {
    
        delegate?.didCloseWalkthrough()
    }
    
    
    func walkthroughPageDidChange(_ pageNumber: Int) {
        
        
        animateButton(pageNumber: pageNumber)
        
        let isLastStep = ((self.walkThrough?.numberOfPages)! - 1 == pageNumber)
      
        self.walkThrough?.hiddenFinishBttn = !isLastStep
       // self.walkThrough?.hiddenCreatePatchBttn = (pageNumber != 1)
        self.walkThrough?.nameMsgLabel.isHidden = !isLastStep
        self.walkThrough?.nameTextField.isHidden = !isLastStep
        
        if (isLastStep) {
            self.walkThrough?.nameTextField.becomeFirstResponder()
        } else if (self.walkThrough?.nameTextField.isFirstResponder)! {
            self.walkThrough?.nameTextField.resignFirstResponder()
        }
        
        
        delegate?.didChangeWalkthroughPage(pageNumber: pageNumber)
    }
    
    fileprivate func animateButton(pageNumber: Int) {
    
        let nextValue = (pageNumber == 0 || pageNumber == 2 ? defaultBottomValue : -80)
        let patchValue = (pageNumber == 1 ? defaultTopPatchBttnValue : -800)
        
//        if #available(iOS 10.0, *) {
//            let bttnAnimation = UIViewPropertyAnimator(duration: 0.2,
//                                                       curve: UIViewAnimationCurve.linear,
//                                                       animations: {
//                                                        
//                                                        self.walkThrough?.bottomNextBttnConstraint.constant = CGFloat(nextValue)
//                                                        self.walkThrough?.view.layoutIfNeeded()
//            })
//        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveLinear, animations:  {
                
                self.walkThrough?.nextButton?.frame.origin.y = CGFloat(nextValue)
                
            }, completion: { (success) in self.walkThrough?.view.layoutIfNeeded() })
//        }
        
//        if #available(iOS 10.0, *) {
//            let createPatchBttn = UIViewPropertyAnimator(duration: 0.2,
//                                                         curve: UIViewAnimationCurve.linear,
//                                                         animations: {
//                                                            
//                                                            self.walkThrough?.topCreatePatchConstraint.constant = CGFloat(patchValue)
//                                                            self.walkThrough?.view.layoutIfNeeded()
//            })
//        } else {
            UIView.animate(withDuration: 0.5, delay: 1.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveLinear, animations:  {
                
                self.walkThrough?.createPatchBttn?.frame.origin.y = CGFloat(patchValue)
                
            }, completion: { (success) in self.walkThrough?.view.layoutIfNeeded() })
//        }
//
//        if #available(iOS 10.0, *) {
//            bttnAnimation.startAnimation()
//        } else {
//            // Fallback on earlier versions
//        }
//        if #available(iOS 10.0, *) {
//            createPatchBttn.startAnimation()
//        } else {
//            // Fallback on earlier versions
//        }
    }
    
    
    
}
