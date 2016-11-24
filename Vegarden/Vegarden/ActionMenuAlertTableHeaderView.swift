//
//  ActionMenuAlertTableHeaderView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 24/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

let headerSectionsHeight: CGFloat = 50

class ActionMenuAlertTableHeaderView: UIView {

    var titleLabel = UILabel()
    var switchView = UIView()
    var switchTitle = UILabel()
    var fullPatchLabel = UILabel()
    var switchAll = UISwitch()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor =  UIColor.lightGray
        
        self.titleLabel.frame = CGRect(x: 0, y: 0, width: 250, height: headerSectionsHeight)
        self.titleLabel.font = UIFont.systemFont(ofSize: 25)
        self.titleLabel.textColor = UIColor.darkGray
        
        
        self.fullPatchLabel.frame = CGRect(x: 0, y: 0, width: 200, height: headerSectionsHeight)
        self.fullPatchLabel.font = UIFont.systemFont(ofSize: 18)
        self.fullPatchLabel.textColor = UIColor.red
        self.fullPatchLabel.text = "This Patch is Full!"
        
        self.switchView = UIView(frame:CGRect(x: 0, y: 0, width: 300, height: 200))
        
        self.switchTitle = UILabel(frame: titleLabel.frame)
        self.switchTitle.text = "Select All Rows"
        self.switchTitle.font = UIFont.systemFont(ofSize: 20)
        self.switchTitle.textColor = UIColor.darkGray
        
        self.switchAll = UISwitch(frame: CGRect(x: 0, y: 0, width: 200, height: headerSectionsHeight))
        //self.switchAll.setOn(false, animated: false)
        
        
        self.switchView.addSubview(self.switchTitle)
        self.switchView.addSubview(self.switchAll)
        
        self.switchTitle.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(150)
        }
        
        self.switchAll.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(14)
            make.bottom.equalToSuperview()
            make.width.equalTo(50)
        }
        
        self.addSubview(titleLabel)
        self.addSubview(fullPatchLabel)
        self.addSubview(switchView)
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(300)
        }

        self.fullPatchLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalTo(self.titleLabel.snp.right)
            make.width.equalTo(200)
        }

        self.switchView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(300)
        }
        
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
