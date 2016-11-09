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
        //self.textAlignment = .right
        self.font = UIFont.systemFont(ofSize: 20)
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.darkGray.cgColor
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
        
//        self.textColor = UIColor.lightGray
//        self.textAlignment = .right
//        self.font = UIFont.systemFont(ofSize: 20)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)

    }
    
}
