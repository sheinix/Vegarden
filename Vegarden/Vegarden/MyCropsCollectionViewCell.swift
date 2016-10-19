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
//    @IBOutlet private weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    
    open var imgView: UIImageView?
    
    var crop: Crop? {
        didSet {
            if let crop = crop {
                imageView.image = UIImage(named:crop.picture!)
                captionLabel.text = crop.name
                commentLabel.text = crop.family
                imgView = imageView
            }
        }
    }
    
//    override init(frame: CGRect) {
//        
//        super.init(frame: frame)
//        backgroundColor = UIColor.lightGray
//        //contentView.addSubview(imageViewContent)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        imageViewContent.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
//        imageViewContent.image = UIImage(named: imageName!)
//    }
    
//    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
//        super.apply(layoutAttributes)
//        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
//            imageViewHeightLayoutConstraint?.constant = attributes.photoHeight
//        }
//    }

}
extension MyCropsCollectionViewCell: VTansitionWaterfallGridViewProtocol {
    
    func snapShotForTransition() -> UIView! {
        
        let snapShotView = UIImageView(image: self.imgView?.image)
        snapShotView.frame = (imgView?.frame)!
        
        return snapShotView
    }
}
