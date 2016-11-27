//
//  SideBarMenuTableViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 10/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class SideBarMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet internal weak var tabImgView: UIImageView!
//    @IBOutlet private weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
//    @IBOutlet private weak var tabTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = Fonts.mainFont
        titleLabel.adjustsFontSizeToFitWidth = true
        self.layer.borderWidth = 1.5
        self.layer.cornerRadius = 9
        self.layer.borderColor = UIColor.clear.cgColor
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
       
 
        self.layer.borderColor = (selected ? Colors.mainColor : UIColor.clear.cgColor)
        self.titleLabel.textColor = (selected ? UIColor(cgColor: Colors.mainColor) : UIColor.darkGray)
        
        super.setSelected(selected, animated: animated)

    }
    
}
