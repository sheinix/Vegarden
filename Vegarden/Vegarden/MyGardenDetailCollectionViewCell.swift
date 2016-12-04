//
//  MyGardenDetailCollectionViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 28/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SnapKit
import SCLAlertView

protocol MyGardenDetailCollectionViewCellProtocol : class {
    
    func willDelete(patch: Paddock!)
}

let buttonsViewHeight = 60
let labelsHeight = 40

class MyGardenDetailCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: MyGardenDetailCollectionViewCellProtocol?
    
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
    var removePatchButton    = UIButton(type: UIButtonType.custom)
    var editRowsButton        = UIButton(type: UIButtonType.custom)
    
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
        
        self.removePatchButton.setRoundedCornerStyled()
        self.removePatchButton.addTarget(self, action: #selector(removePatch), for: .touchUpInside)
        self.removePatchButton.setTitle("Remove Patch", for: .normal)
        self.removePatchButton.backgroundColor = UIColor.red
        self.removePatchButton.titleLabel?.sizeToFit()
        
        self.editRowsButton.setRoundedCornerStyled()
        self.editRowsButton.addTarget(self, action: #selector(editRows), for: .touchUpInside)
        self.editRowsButton.setTitle("Edit Rows", for: .normal)

        self.editRowsButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.editRowsButton.titleLabel?.sizeToFit()
        
        
        self.contentView.addSubview(self.patchLabel)
        self.contentView.addSubview(self.plantedRowsLabel)
        self.contentView.addSubview(self.freeRowsLabel)
        self.contentView.addSubview(self.totalRows)
        
//        self.buttonsContainerView.addSubview(self.removePatchButton)
//        self.buttonsContainerView.addSubview(self.addRowsButton)
//        self.buttonsContainerView.addSubview(self.deleteRows)
        self.contentView.addSubview(self.removePatchButton)
        self.contentView.addSubview(self.editRowsButton)
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        
    }
    
    private func setupConstraints() {
        
        setupConstraintsForButtons()
        
        setupConstraintsForLabels()
        
    }
    
    private func setupConstraintsForLabels () {
        
        
        self.freeRowsLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalTo(editRowsButton.snp.top).offset(-5)
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

    
        self.removePatchButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(buttonsViewHeight)
            make.width.equalToSuperview().dividedBy(2)
        }
    
        self.editRowsButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.removePatchButton.snp.right)
            make.height.equalTo(buttonsViewHeight)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
        }
    
    }
    
    @objc private func removePatch(_: UIButton) {
        
        self.delegate?.willDelete(patch: self.patch!)
            
}

    @objc private func editRows(_: UIButton) {
        
        let appearance = SCLAlertView.SCLAppearance(kWindowWidth: screenWidth * 0.9,
                                                    kWindowHeight: screenHeight * 0.9,
                                                    showCloseButton: true,
                                                    showCircularIcon: false)
        
        let alert = RowAddEditViewController(appearance: appearance, patch: patch)
        
        
        let _ = alert.showEdit("Edit Rows of " + (patch?.name!)!, subTitle: "")

    }
}
