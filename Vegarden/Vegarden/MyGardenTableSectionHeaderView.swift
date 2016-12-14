//
//  MyGardenTableSectionHeaderView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 1/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

protocol TableHeaderAddButtonProtocol: class {
 
    func didPushAddButton(button: UIButton)
}

class MyGardenTableSectionHeaderView: UIView {

    var titleLabel = UILabel()
    var addPatchButton = UIButton(type: .custom)
    weak var delegate: TableHeaderAddButtonProtocol?
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupViews()
        
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    fileprivate func setupViews() {
        
//        self.layer.borderColor = Colors.mainColorUI.cgColor
//        self.layer.borderWidth = 1
//        self.layer.cornerRadius = UINumbericConstants.commonCornerRadius
        
        self.titleLabel.font = Fonts.mainFont
        self.titleLabel.textColor = Colors.mainColorUI
        
        self.addPatchButton.setImage(UIImage(named:"plusbutton"), for: .normal)
        self.addPatchButton.frame = CGRect(x: 0, y: 0, width: 70, height: 75)
        self.addPatchButton.layer.cornerRadius = self.addPatchButton.frame.size.width/2
        self.addPatchButton.clipsToBounds = true
        self.addPatchButton.addTarget(self, action: #selector(buttonPushed),for: .touchUpInside)
        
        addSubview(self.titleLabel)
        addSubview(self.addPatchButton)
        
    }
    
    fileprivate func setupConstraints() {
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(screenWidth).multipliedBy(0.7)
        }
        
        self.addPatchButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
    }
    
    @objc fileprivate func buttonPushed(sender: UIButton) {
        
        self.delegate?.didPushAddButton(button: sender)
    }
}
