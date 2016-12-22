//
//  MasterWalkthroughViewController.swift
//  Vegarden
//
//  Created by Sarah Cleland on 22/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import BWWalkthrough

class MasterWalkthroughViewController: BWWalkthroughViewController {

    @IBOutlet weak open var createPatchBttn: UIButton!
    @IBOutlet weak open var finishBttn: UIButton!
    
    open var hiddenCreatePatchBttn : Bool? {
        
        didSet {
            self.createPatchBttn.isHidden = hiddenCreatePatchBttn!
        }
    }
    
    open var hiddenFinishBttn : Bool? {
        
        didSet {
            self.finishBttn.isHidden = hiddenFinishBttn!
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createPatchBttn.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.createPatchBttn.layer.shadowOpacity = 2
        self.createPatchBttn.layer.shadowRadius = 5
        self.createPatchBttn.layer.shadowColor = UIColor.darkGray.cgColor
        
        
        self.finishBttn.layer.shadowOffset = CGSize(width: 2, height: -2)
        self.finishBttn.layer.shadowOpacity = 2
        self.finishBttn.layer.shadowRadius = 5
        self.finishBttn.layer.shadowColor = UIColor.darkGray.cgColor
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(newPatchAdded),
                                               name: NSNotification.Name(rawValue: NotificationIds.NotiKeyNewPatch),
                                               object: nil)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc fileprivate func newPatchAdded(notification: NSNotification) {
        
        self.createPatchBttn.isHidden = true
        self.nextButton?.sendActions(for: .touchUpInside)
        
    }
    
    @IBAction func createNewPatch(_ sender: Any) {
        
        let appearance = Appereance().appereanceForAlert(frame: self.view.bounds, color: Colors.mainColorUI, needsTitle: true)
        
        let alert = PatchAddEditViewController(appearance: appearance, patch: nil)
        
        let _ = alert.showInfo("Add New Patch",
                               subTitle: "",
                               closeButtonTitle: "Close",
                               duration: 0,
                               colorStyle: Colors.mainColorHex,
                               colorTextButton: 0xFFFFFF,
                               animationStyle: .topToBottom)
    }
    
    @IBAction func finishAction(_ sender: Any) {
        
        self.delegate?.walkthroughCloseButtonPressed!()
    }
    
}
