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

        self.greetingsLabel.text = Date.greetings() + " Sarah!"
        self.timeLabel.text = Date().currentTime()
        self.dateLabel.text = Date().inCellDateFormat()
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    
    fileprivate func setupViews() {
        
        self.backgroundColor = Colors.greetingsHeaderColor
        
        self.greetingsLabel.textColor = UIColor.white
        self.greetingsLabel.font = UIFont.systemFont(ofSize: 36)
        
        self.dateLabel.textColor = UIColor.white
        self.dateLabel.font = Fonts.mainFont
        
        self.timeLabel.textColor = UIColor.white
        self.timeLabel.font = Fonts.mainFont
        
        self.weatherView.isHidden = true
        self.weatherLabel.isHidden = true
        self.weatherImgView.isHidden = true
        self.weatherDegreesLabel.isHidden = true
    }
}
