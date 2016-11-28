//
//  MyGardenDetailCollectionViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 28/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SnapKit

class MyGardenDetailCollectionViewCell: UICollectionViewCell {
    
    var patch : Paddock? {
        
        didSet {
            
            if let newPatch = patch {
                patchLabel.text = patch?.name!
                totalRows.text = "Total Rows : " + String(describing: newPatch.rows?.count)
                plantedRowsLabel.text = "Planted Rows : " + String(describing: newPatch.plantedRows.count)
                freeRowsLabel.text = "Free Rows : " + String(describing: newPatch.freeRows.count)
            }

        }
    }
    
    var patchLabel = UILabel()
    var plantedRowsLabel  = UILabel()
    var freeRowsLabel = UILabel()
    var totalRows = UILabel()
    
    var removePatchButton = UIButton(type: UIButtonType.custom)
    var addRowsButton  = UIButton(type: UIButtonType.custom)
    var deleteRows  = UIButton(type: UIButtonType.custom)
    
    
    override func awakeFromNib() {
      
        super.awakeFromNib()
        
        setupConstraints()
    }
    
    
    
    
    private func setupConstraints() {
    
        
        
    }

}
