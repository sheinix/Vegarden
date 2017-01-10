//
//  MasterWalkthroughViewController.swift
//  Vegarden
//
//  Created by Sarah Cleland on 22/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import BWWalkthrough

let defaultBottomValue =  iOS10available() ? 78 : screenHeight - 200
let defaultTopPatchBttnValue = iOS10available() ? 380 : (screenHeight/2) - 100

class MasterWalkthroughViewController: BWWalkthroughViewController {

    @IBOutlet weak open var createPatchBttn: UIButton!
    @IBOutlet weak open var finishBttn: UIButton!
    @IBOutlet weak var nameMsgLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bottomNextBttnConstraint: NSLayoutConstraint!
    @IBOutlet weak var topCreatePatchConstraint: NSLayoutConstraint!
    
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
    
    open var hiddenNextBttn : Bool? {
        didSet {
            self.nextButton?.isHidden = hiddenNextBttn!
    
    }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createPatchBttn.setClearStyledButton()
        self.finishBttn.setClearStyledButton()
        self.nextButton?.setClearStyledButton()
        self.nameTextField.applyShadowsForWalkthrough()
        
        self.nameTextField.delegate = self
        
        
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
        
        self.view.showConfirmViewWith(title: "Cool! Patch was created!",
                                      frame: self.view.bounds,
                                      afterAction: {self.nextButton?.sendActions(for: .touchUpInside)})
        
        
        
    }
    
    @IBAction func createNewPatch(_ sender: Any) {
        
        let appearance = Appereance().appereanceForAlert(frame: self.view.bounds, color: Colors.mainColorUI, needsTitle: true)
        
        let alert = PatchAddEditViewController(appearance: appearance, patch: nil)
        
        let _ = alert.showInfo("Create your First Patch",
                               subTitle: "",
                               closeButtonTitle: "Close",
                               duration: 0,
                               colorStyle: Colors.mainColorHex,
                               colorTextButton: 0xFFFFFF,
                               animationStyle: .topToBottom)
    }
    
    @IBAction func finishAction(_ sender: Any) {
        
        //Send a resign first responder in order to resign all textfields that has data!
//        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
        
        if !((nameTextField.text?.isEmpty)!) {
            
            UserDefaults.standard.synchronize()
            self.delegate?.walkthroughCloseButtonPressed!()
        
        } else {
            
            showAlert()
        }
        
    }
    
}
extension MasterWalkthroughViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        validate(txtField: textField)

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        validate(txtField: textField)
    }
    
    
    fileprivate func validate(txtField: UITextField) {
       
        if (txtField.text?.isEmpty)! {
            showAlert()
        } else {
            
            UserDefaults.standard.setValue(txtField.text!, forKey: UserDefaultsKeys.userNameKey)
        }
 
    }
    
    fileprivate func showAlert() {
        self.showAlertView(title: "Please provide a name!",
                           message: "I promise, this is the last step! :)",
                           style: .alert,
                           confirmBlock: {},
                           cancelBlock: {})
    }
    
}
