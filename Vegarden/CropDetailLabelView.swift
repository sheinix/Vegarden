//
//  CropDetailLabelView.swift
//  Vegarden
//
//  Created by Sarah Cleland on 7/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class CropDetailLabelView: UIView {
    
    @IBOutlet weak var familyValue: CropDetailLabel!
    @IBOutlet weak var typeValue: CropDetailLabel!
    @IBOutlet weak var phLevelValue: CropDetailLabel!
    @IBOutlet weak var spacingValue: CropDetailLabel!
    @IBOutlet weak var isInGarden: CropDetailLabel!
    @IBOutlet weak var classificationValue: CropDetailLabel!
    
    class func loadFromNib() -> CropDetailLabelView? {
        
        let nib = UINib(nibName: "CropDetailLabelView", bundle: Bundle.main)
            
        return nib.instantiate(withOwner: self, options: nil)[0] as? CropDetailLabelView
    }
    
    init(frame: CGRect, crop: Crop) {
        
        super.init(frame: frame)
    
        setupView()
        
        setupValuesWith(crop: crop)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
    
        super.init(coder: aDecoder)
    }
    
    private func setupView () {
        
        let view = Bundle.main.loadNibNamed("CropDetailLabelView", owner: self, options: nil)?[0] as! UIView
        
        self.addSubview(view)
        
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.backgroundColor = UIColor.yellow
    }
    
    public func setupValuesWith(crop: Crop) {
        
        self.typeValue.text = crop.cropTypeStringValue
        self.familyValue.text = crop.family
        self.phLevelValue.text = crop.phLevels
        self.spacingValue.text = String(crop.spacing)
        self.isInGarden.text = (crop.owned ? "Yes" : "No")
        self.classificationValue.text = crop.plantType
    }
}
