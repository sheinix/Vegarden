//
//  PatchEditionTableViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 30/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SnapKit

class PatchEditionTableViewCell: UITableViewCell {
    
    var txtField = SkyFloatingLabelTextField()
    var hasPlantedCropsLabel : UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.txtField.setupPatchEditionTextView()
        addSubview(self.txtField)
        
        self.txtField.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        if (reuseIdentifier == CellIdentifiers.RowsEditionCellIdentifier) {
          
            self.hasPlantedCropsLabel = UILabel()
            self.hasPlantedCropsLabel?.text = "Has Planted Crops"
            self.hasPlantedCropsLabel?.textColor = UIColor.red
            self.hasPlantedCropsLabel?.isHidden = true
            
            addSubview(self.hasPlantedCropsLabel!)
        }
    }
    
    public func needsRemakeConstraints(hasPlantedRow: Bool) {
        
        self.hasPlantedCropsLabel?.isHidden = !hasPlantedRow
        
        if (hasPlantedRow) {
            
            self.txtField.snp.remakeConstraints({ (remake) in
                remake.width.equalToSuperview().multipliedBy(0.65)
            })
            
            self.hasPlantedCropsLabel?.snp.makeConstraints { (make) in
                make.width.equalToSuperview().multipliedBy(0.3)
                make.right.equalToSuperview().offset(5)
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    public func setTxtViewWith(patch: Paddock?, forCellAt row: Int) {
        
        let isNewPatch = !(patch != nil)
        
        switch row {
            case 0:
                self.txtField.placeholder =  "Name"
                self.txtField.title = "Patch Name"
                self.txtField.text = (isNewPatch ? "" : patch!.name)
            case 1:
                self.txtField.placeholder =  "Location"
                self.txtField.title = "Location of the Patch"
                self.txtField.text = (isNewPatch ? "" : patch!.location?.locationName!)
            case 2:
                self.txtField.placeholder =  "Soil pH Level"
                self.txtField.title = "The Ph of the Soil"
                self.txtField.text = (isNewPatch ? "" : String(patch!.soil!.phLevel))
            case 3:
                self.txtField.placeholder =  "Rows Quantity"
                self.txtField.title = "Number of Rows in Patch"
                self.txtField.text = (isNewPatch ? "" : String(patch!.rows!.count))
            case 4:
                self.txtField.placeholder =  "Row names prefix"
                self.txtField.title = "Prefix of Row names in Patch"
                self.txtField.text = (isNewPatch ? "" : patch!.rowsNamePrefix)
        
            default:
                break
        }
    }
}
