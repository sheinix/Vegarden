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
                captionLabel.text = crop.family
                commentLabel.text = crop.name
                imgView = imageView
            }
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
//        self.captionLabel.font = UIFont.systemFont(ofSize: 20)
//        self.captionLabel.textColor = UIColor.white
//        
//        self.commentLabel.font = UIFont.systemFont(ofSize: 40)
//        self.commentLabel.textColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        
        self.captionLabel.font = UIFont.systemFont(ofSize: 20)
        self.captionLabel.textColor = UIColor.white
        
        self.commentLabel.font = UIFont.systemFont(ofSize: 30)
        self.commentLabel.textColor = UIColor.white
        
        super.awakeFromNib()

    }
    
//    required init(coder aDecoder: NSCoder) {
//        //fatalError("init(coder:) has not been implemented")
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
        
        //In case a dummy cell was created for an empty collection...
        if (self.imgView == nil) {
            
            return UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize.zero))
        }
        
        let snapShotView = UIImageView(image: self.imgView?.image)
        snapShotView.frame = (imgView?.frame)!
        
        return snapShotView
    }
}
