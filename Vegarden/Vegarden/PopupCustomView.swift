//
//  PopupCustomView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 16/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class PopupCustomView: Popup {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    public class func getAddCropTableViewPop()-> PopupCustomView {
        
        let popUp = PopupCustomView(title: "Add Crop",
                                    subTitle: "Select crops from the list",
                                    cancelTitle: "Cancel",
                                    successTitle: "Done",
                                    cancel: { print("cancel")},
                                    successBlock: {print("succes")})
        
        
        popUp?.backgroundBlurType = PopupBackGroundBlurType.dark
        popUp?.backgroundColor = UIColor.white
        popUp?.roundedCorners = true
        popUp?.incomingTransition = PopupIncomingTransitionType.slideFromBottom
        popUp?.outgoingTransition = PopupOutgoingTransitionType.slideToTop
        
        
        return popUp!
    }
    
    
    convenience init(title: String, subTitle:String, cancelTitle:String, succesTitle:String, cancelBlock:@escaping (blocky), succesBlock:@escaping (blocky), view: UIView) {
    
        self.init(title: title, subTitle: subTitle, cancelTitle: cancelTitle, successTitle: succesTitle, cancel: cancelBlock, successBlock: succesBlock)
        
     
        
    }
    
}
