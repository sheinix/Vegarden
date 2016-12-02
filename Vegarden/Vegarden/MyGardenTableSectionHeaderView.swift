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
        
//        setupViews()
//        
//        setupConstraints()
        
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
        
        self.layer.borderColor = UIColor.darkText.cgColor
        self.layer.borderWidth = 2
        
        
        
        self.titleLabel.font = Fonts.mainFont
        
     
        self.addPatchButton.setImage(UIImage(named:"plusbutton"), for: .normal)
        self.addPatchButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.addPatchButton.layer.cornerRadius = self.addPatchButton.frame.size.width/2
        self.addPatchButton.clipsToBounds = true
        self.addPatchButton.addTarget(self, action: #selector(buttonPushed),for: .touchUpInside)
//        self.addPatchButton.layer.cornerRadius = 1
//        self.addPatchButton.layer.borderWidth = 3
        
        addSubview(self.titleLabel)
        addSubview(self.addPatchButton)
        
    }
    
    fileprivate func setupConstraints() {
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(screenWidth).multipliedBy(0.7)
        }
        
        self.addPatchButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
    }
    
    @objc fileprivate func buttonPushed(sender: UIButton) {
        
        self.delegate?.didPushAddButton(button: sender)
    }
}
