//
//  VCropDetailPageTableViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 16/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

// This tableview cell is the one that is inside the cropdetailview cell!

class VCropDetailPageTableViewCell: UITableViewCell {

    var viewsContainer : UIStackView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        let imageView :UIImageView = self.imageView!;
        imageView.frame = CGRect.zero
        
        if (imageView.image != nil) {
            
            let imageHeight = imageView.image!.size.height*screenWidth/imageView.image!.size.width
            imageView.frame = CGRect(x:0, y:0, width:screenWidth, height:imageHeight)
            imageView.layer.cornerRadius = UINumbericConstants.commonCornerRadius
            
        } else {
            
            viewsContainer = UIStackView(frame: CGRect(x:0, y:0, width:screenWidth, height: screenHeight))
            viewsContainer?.alignment = UIStackViewAlignment.bottom
            viewsContainer?.axis = .horizontal
            viewsContainer?.distribution = UIStackViewDistribution.fillProportionally
            
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
//        viewsContainer?.alignment = UIStackViewAlignment.bottom
//        viewsContainer?.axis = .horizontal
//        viewsContainer?.distribution = UIStackViewDistribution.fillProportionally
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
