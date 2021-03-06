//
//  CropDetailLabel.swift
//  Vegarden
//
//  Created by Sarah Cleland on 7/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

public class CropDetailLabel: UILabel {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.textColor = UIColor.lightGray
        self.textAlignment = .left
        self.font = Fonts.appleGoticUltraLightFont
        self.sizeToFit()
        self.textColor = UIColor.darkText
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
    }

    init() {
        super.init(frame: CGRect.zero)
    }
}

public class CropDetailText: UILabel {
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.sizeToFit()
        self.textAlignment = .left
        self.font = Fonts.cropInfoLabelFont
        self.numberOfLines = 0
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)

    }
    
}
