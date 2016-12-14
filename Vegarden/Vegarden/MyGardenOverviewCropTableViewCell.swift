//
//  MyGardenOverviewCropTableViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 28/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SnapKit

class MyGardenOverviewCropTableViewCell: UITableViewCell {

    var harvestDate : UILabel?
    var progressBar : UIView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupViews() {
        
        //self.layer.borderColor = Colors.mainColor
        //self.layer.borderWidth = 1
      //  self.layer.cornerRadius = UINumbericConstants.commonCornerRadius
        
        
        self.harvestDate = UILabel()
        self.harvestDate?.font = Fonts.gardenOverviewFont
        self.harvestDate?.textColor = Colors.mainColorUI
        self.harvestDate?.sizeToFit()
        
        self.progressBar = UIView()
        self.progressBar?.backgroundColor = Colors.plantColor
        self.progressBar?.layer.borderWidth = 1
        self.progressBar?.layer.borderColor = Colors.mainColor
        self.progressBar?.layer.cornerRadius = UINumbericConstants.commonCornerRadius
        
        self.textLabel?.font = Fonts.gardenOverviewFont
        self.textLabel?.textColor = Colors.mainColorUI
        self.textLabel?.sizeToFit()
        
        
        addSubview(self.harvestDate!)
        addSubview(self.progressBar!)
        
        
    }
    
    private func setupConstraints() {
    
        self.textLabel?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(160)
        })
        
        self.textLabel?.backgroundColor = UIColor.green
        
        
        self.harvestDate?.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(120)
        }
        
        self.progressBar?.snp.makeConstraints { (make) in
            make.right.equalTo((self.harvestDate?.snp.left)!).offset(-10)
            make.left.equalTo((self.textLabel?.snp.right)!).offset(10)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.centerY.equalToSuperview()
        }
        
    }
}
