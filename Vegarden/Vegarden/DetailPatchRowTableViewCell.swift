//
//  DetailPatchRowTableViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 28/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class DetailPatchRowTableViewCell: UITableViewCell {

    var rowName = UILabel()
    var switchControl = UISwitch()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization coded
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.switchControl.setOn(false, animated: false)
        
        self.contentView.addSubview(rowName)
        self.contentView.addSubview(switchControl)
        
        rowName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(5)
            make.width.greaterThanOrEqualTo(300)
        }
        
        switchControl.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(5)
            make.width.equalTo(90)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        myLabel.frame = CGRect(x: 20, y: 0, width: 70, height: 30)
//    }

    
}
