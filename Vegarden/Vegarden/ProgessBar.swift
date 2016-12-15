//
//  ProgessBar.swift
//  Vegarden
//
//  Created by Sarah Cleland on 15/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class ProgessBar: YLProgressBar {

    override var progress: CGFloat {
        didSet {
            if (progress >= 0.2) {
                self.indicatorTextDisplayMode = .progress
                self.indicatorTextLabel.textColor = UIColor.white
            }
        }
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.type = .rounded
        self.progressTintColor = Colors.mainColorUI
        self.hideStripes = true
        self.progressStretch = false
        self.uniformTintColor = true
        self.hideGloss = true
        self.progressBarInset = 0
        self.indicatorTextDisplayMode = .track
        self.indicatorTextLabel.textColor = Colors.mainColorUI
        self.cornerRadius = UINumbericConstants.commonCornerRadius
        self.indicatorTextLabel.font = UIFont.systemFont(ofSize: 8)
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.mainColor
        self.layer.cornerRadius = UINumbericConstants.commonCornerRadius
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

}
