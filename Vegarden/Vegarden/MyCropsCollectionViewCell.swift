//
//  MyCropsCollectionViewCell.swift
//  
//
//  Created by Juan Nuvreni on 10/9/16.
//
//

import UIKit

class MyCropsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    
    var crop: CropVeggie? {
        didSet {
            if let crop = crop {
                imageView.image = crop.image
                captionLabel.text = crop.caption
                commentLabel.text = crop.comment
            }
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            imageViewHeightLayoutConstraint.constant = attributes.photoHeight
        }
    }

}
