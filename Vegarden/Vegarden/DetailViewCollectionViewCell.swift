//
//  DetailViewCollectionViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 25/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class DetailViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var stageTitle: UILabel!
    @IBOutlet weak var progressStepView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var date2Label: UILabel!
    @IBOutlet weak var value2Label: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 8
        
    }

    
    
    
}
