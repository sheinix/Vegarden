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
        
        setupViews()

        var greetingsMsg = Date.greetings()
        
        if let userName = UserDefaults.standard.value(forKey: UserDefaultsKeys.userNameKey) as? String {
            
            greetingsMsg = greetingsMsg! + " " + userName
        }
        
        self.greetingsLabel.text = greetingsMsg
        self.timeLabel.text = Date().currentTime()
        self.dateLabel.text = Date().inCellDateFormat()
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    
    fileprivate func setupViews() {
     
        //Fix for iPadPro 12.9 inch:
       // if UIDevice.current.isiPadPro12Inch {
            self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: self.frame.height)
       // }
        self.layerGradientWith(colors: Colors.headerGradient)
        
        self.greetingsLabel.textColor = UIColor.white
        self.greetingsLabel.applyLightShadow()
        self.greetingsLabel.font = Fonts.greetingFont
        
        self.dateLabel.textColor = UIColor.white
        self.dateLabel.font = Fonts.greetingTimeFont
        self.dateLabel.applyLightShadow()
        
        self.timeLabel.textColor = UIColor.white
        self.timeLabel.font = Fonts.greetingTimeFont
        self.timeLabel.applyLightShadow()
        
        self.weatherView.isHidden = true
        self.weatherLabel.isHidden = true
        self.weatherImgView.isHidden = true
        self.weatherDegreesLabel.isHidden = true
    }
}
