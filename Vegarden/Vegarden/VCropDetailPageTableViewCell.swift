//
//  VCropDetailPageTableViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 16/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SnapKit
import QuartzCore

// This tableview cell is the one that is inside the cropdetailview cell!

class VCropDetailPageTableViewCell: UITableViewCell {

    var viewsContainer : UIStackView?
    var removeButton   : UIButton?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.textLabel?.font = UIFont.systemFont(ofSize: 13)
        self.imageView?.layer.shouldRasterize = true
        self.imageView?.layer.masksToBounds = true
        self.imageView?.layer.cornerRadius = 9
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let imageView : UIImageView = self.imageView!;
        imageView.frame = CGRect.zero
        
        if (imageView.image != nil) {
            
            let imageHeight = imageView.image!.size.height*screenWidth/imageView.image!.size.width
            imageView.frame = CGRect(x:0, y:0, width:screenWidth, height:imageHeight)
            
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 9
            
        } else {
            
            layoutStackedViews()

        }
    }
    
    private func layoutStackedViews() {

        if (viewsContainer != nil) {
            return
        }
        
        viewsContainer = UIStackView(frame: CGRect(x:0, y:0, width:contentView.frame.width, height: contentView.frame.height))
        
        viewsContainer?.axis = .horizontal
        viewsContainer?.distribution = .equalSpacing
        
        addSubview(viewsContainer!)
        
        viewsContainer?.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    public func setupStackedViewsWith(crop: Crop, and frame: CGRect) {
        
        if (viewsContainer != nil) {
            return
        }
        
        layoutStackedViews()
        
        let frameLeft = CGRect(x: 0, y: 0, width: frame.width/2, height: frame.height)
        var frameRight = frameLeft
        frameRight.origin.x = frameLeft.width
        
        let leftCol  = CropDetailLabelView.loadFromNib()
        leftCol?.setupValuesWith(crop: crop)
        let rightCol = CropDetailTextView(frame: frameRight, crop: crop)
        
        
        viewsContainer?.addArrangedSubview(leftCol!)
        viewsContainer?.addArrangedSubview(rightCol)

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
