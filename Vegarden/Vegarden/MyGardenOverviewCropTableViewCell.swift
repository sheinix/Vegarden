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
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
       
        setupViews()
        
        setupConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupViews() {
        
        self.harvestDate = UILabel()
        self.harvestDate?.sizeToFit()
        self.harvestDate?.backgroundColor = UIColor.red
        
        self.progressBar = UIView()
        self.progressBar?.backgroundColor = UIColor(cgColor: Colors.mainColor)
        
        
        addSubview(self.harvestDate!)
        addSubview(self.progressBar!)
        
        
    }
    
    private func setupConstraints() {
    
        self.harvestDate?.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(120)
        }
        
        self.progressBar?.snp.makeConstraints { (make) in
            make.right.equalTo((self.harvestDate?.snp.left)!).offset(10)
            make.left.equalTo((self.textLabel?.snp.right)!).offset(10)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
    }
}
