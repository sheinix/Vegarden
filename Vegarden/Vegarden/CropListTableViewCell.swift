//
//  CropListTableViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 17/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class CropListTableViewCell: UITableViewCell {
    
        override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
            
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.textLabel?.font = UIFont.systemFont(ofSize: 13)
            self.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            
            super.layoutSubviews()
//            let imageView :UIImageView = self.imageView!;
//            imageView.frame = CGRect.zero
//            
//            if (imageView.image != nil) {
//                let imageHeight = imageView.image!.size.height*screenWidth/imageView.image!.size.width
//                imageView.frame = CGRect(x:0, y:0, width:screenWidth, height:imageHeight)
//            }
        }
        
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
//        override func setSelected(_ selected: Bool, animated: Bool) {
//            super.setSelected(selected, animated: animated)
//            
//            // Configure the view for the selected state
//        }

}
