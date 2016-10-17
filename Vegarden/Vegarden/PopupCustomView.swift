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
        
        
        let customView = UIView(frame: CGRect(x:0, y:0, width:300, height:400))
        customView.backgroundColor = UIColor.yellow
        
        let popUp = PopupCustomView(title: "Add Crop", subTitle: "Select from the list", textFieldPlaceholders: [], cancelTitle: "Cancel", successTitle: "Done", cancel: {}, successBlock: {}, customView: customView)
        
        popUp?.backgroundBlurType = PopupBackGroundBlurType.dark
        popUp?.backgroundColor = UIColor.white
        popUp?.roundedCorners = true
        popUp?.incomingTransition = PopupIncomingTransitionType.slideFromBottom
        popUp?.outgoingTransition = PopupOutgoingTransitionType.slideToTop
        
        
        
        return popUp!
    }
}
