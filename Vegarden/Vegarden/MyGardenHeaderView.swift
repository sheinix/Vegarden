//
//  MyGardenHeaderView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 1/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class MyGardenHeaderView: UIView {

    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
   
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImgView: UIImageView!
    @IBOutlet weak var weatherDegreesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    
    
}
