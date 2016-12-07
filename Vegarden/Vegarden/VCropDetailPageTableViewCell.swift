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

    var cropInfoView : CropInformationView = CropInformationView.loadFromNibNamed(nibNamed: "CropInformationView") as! CropInformationView
    var cropDetailView : CropDetailLabelView = CropDetailLabel.loadFromNibNamed(nibNamed: "CropDetailLabelView") as! CropDetailLabelView
    var removeButton   : UIButton?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.textLabel?.font = UIFont.systemFont(ofSize: 13)
        self.imageView?.layer.shouldRasterize = true
        self.imageView?.layer.masksToBounds = true
        self.imageView?.layer.cornerRadius = 9
        self.isUserInteractionEnabled = true
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
            
          
        }
    }
    
    public func setupCropInfoWith(crop: Crop) {

        if !(self.cropInfoView.hasSuperview && self.cropDetailView.hasSuperview) {
            
            setupCellViews()
        }
        
        self.cropInfoView.setupViewWith(crop: crop)
        self.cropDetailView.setupValuesWith(crop: crop)
        
    }
    
    fileprivate func setupCellViews() {
        
        addSubview(self.cropInfoView)
        addSubview(self.cropDetailView)
    
        self.cropDetailView.layer.borderColor = UIColor.red.cgColor
        self.cropDetailView.layer.borderWidth = 2
        self.cropInfoView.layer.borderColor = UIColor.green.cgColor
        self.cropInfoView.layer.borderWidth = 2
    
        setupConstraints()

    }

    fileprivate func setupConstraints() {
        
        self.cropInfoView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.greaterThanOrEqualTo(300)
        }
        
        
        self.cropDetailView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalTo(self.cropInfoView.snp.left)
            make.height.equalTo(200)
        }
        
    }
}
