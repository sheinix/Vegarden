//
//  ConfirmationView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 17/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import M13Checkbox
import SnapKit

class ConfirmationView: UIView {

    var checkBox : M13Checkbox? = nil
    var msgLabel : UILabel = UILabel()
    
    convenience init(frame: CGRect, title: String) {
        
        self.init(frame: frame)
        
        setupCheckBox(frame: frame, title: title)
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    
    private func setupCheckBox(frame : CGRect, title: String) {
        
        self.addBlurEffect(style: UIBlurEffectStyle.dark)
        
        let size = 120
        checkBox = M13Checkbox(frame: CGRect(x: (Int(frame.width/2))-size,
                                             y: (Int(frame.height/2))-size,
                                         width: size,
                                        height: size))

        checkBox?.tintColor = UIColor.green
        checkBox?.secondaryTintColor = UIColor.blue
        checkBox?.stateChangeAnimation = .fill
        checkBox?.checkmarkLineWidth = 5
        
        self.addSubview(checkBox!)
        
        msgLabel.textColor = UIColor.white
        msgLabel.font = UIFont.systemFont(ofSize: 50)
        msgLabel.text = title
        
        self.addSubview(msgLabel)
    
        let centerX = frame.width/2
        let centerY = frame.height/2
        
        checkBox?.snp.makeConstraints { (make) in
            make.centerX.equalTo(centerX)
            make.centerY.equalTo(centerY)
            make.width.equalTo(size)
            make.height.equalTo(size)
        }
        
        msgLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo((checkBox?.snp.centerX)!)
            make.top.equalTo((checkBox?.snp.bottom)!).offset(10)
            
        }
    }

}
