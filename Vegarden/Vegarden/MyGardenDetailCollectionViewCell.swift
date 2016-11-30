//
//  MyGardenDetailCollectionViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 28/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SnapKit

let buttonsViewHeight = 60
let labelsHeight = 40

class MyGardenDetailCollectionViewCell: UICollectionViewCell {
    
    var patch : Paddock? {
        
        didSet {
            
            if let newPatch = patch {
                patchLabel.text = patch?.name!
                totalRows.text = "Total Rows : " + String(newPatch.rows!.count)
                plantedRowsLabel.text = "Planted Rows : " + String(newPatch.plantedRows.count)
                freeRowsLabel.text = "Free Rows : " + String(describing: newPatch.freeRows.count)
            }
        }
    }

    var patchLabel           = UILabel()
    var plantedRowsLabel     = UILabel()
    var freeRowsLabel        = UILabel()
    var totalRows            = UILabel()
    var buttonsContainerView = UIView()
    var removePatchButton    = UIButton(type: UIButtonType.custom)
    var addRowsButton        = UIButton(type: UIButtonType.custom)
    var deleteRows           = UIButton(type: UIButtonType.custom)
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupViews()
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    

    override func awakeFromNib() {
      
        super.awakeFromNib()
        
    }
    
    private func setupViews() {
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        
        self.removePatchButton.setRoundedCornerStyled()
        self.removePatchButton.addTarget(self, action: #selector(removePatch), for: .touchUpInside)
        self.removePatchButton.setTitle("Remove Patch", for: .normal)
        self.removePatchButton.titleLabel?.sizeToFit()
        
        self.addRowsButton.setRoundedCornerStyled()
        self.addRowsButton.addTarget(self, action: #selector(addRows), for: .touchUpInside)
        self.addRowsButton.setTitle("+", for: .normal)
        self.addRowsButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.addRowsButton.titleLabel?.sizeToFit()
        
        self.deleteRows.setRoundedCornerStyled()
        self.deleteRows.addTarget(self, action: #selector(deleteRowsFromPatch), for: .touchUpInside)
        self.deleteRows.setTitle("-", for: .normal)
        self.deleteRows.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.deleteRows.titleLabel?.sizeToFit()
        
        addSubview(self.patchLabel)
        addSubview(self.plantedRowsLabel)
        addSubview(self.freeRowsLabel)
        addSubview(self.totalRows)
        
        self.buttonsContainerView.addSubview(self.removePatchButton)
        self.buttonsContainerView.addSubview(self.addRowsButton)
        self.buttonsContainerView.addSubview(self.deleteRows)
        
        addSubview(self.buttonsContainerView)
        
    }
    
    private func setupConstraints() {
        
        setupConstraintsForButtons()
        
        setupConstraintsForLabels()
        
    }
    
    private func setupConstraintsForLabels () {
        
        
        self.freeRowsLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalTo(buttonsContainerView.snp.top).offset(-5)
            make.height.equalTo(labelsHeight)
        }
        
        self.plantedRowsLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalTo(freeRowsLabel.snp.top).offset(5)
            make.height.equalTo(labelsHeight)
        }
        
        self.totalRows.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalTo(plantedRowsLabel.snp.top).offset(5)
            make.height.equalTo(labelsHeight)
        }
        
        self.patchLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview()
            make.bottom.equalTo(totalRows.snp.top)
        }
        
    }
    
    
    private func setupConstraintsForButtons() {
    
        self.buttonsContainerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(buttonsViewHeight)
        }
    
        self.removePatchButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
        }
    
        self.addRowsButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.removePatchButton.snp.right)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(self.removePatchButton.snp.width).dividedBy(2)
        }
    
        self.deleteRows.snp.makeConstraints { (make) in
            make.left.equalTo(self.addRowsButton.snp.right)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(self.removePatchButton.snp.width).dividedBy(2)
        }
    }
    
    @objc private func removePatch(_: UIButton) {
        
    }
    @objc private func addRows(_: UIButton) {
        
    }
    @objc private func deleteRowsFromPatch(_: UIButton) {
        
    }
    
}
