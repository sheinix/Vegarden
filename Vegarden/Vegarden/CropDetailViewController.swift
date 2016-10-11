//
//  CropDetailViewController.swift
//  Vegarden
//
//  Created by Sarah Cleland on 11/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import RMPZoomTransitionAnimator

class CropDetailViewController: UIViewController {

    
    @IBOutlet weak var cropImgView: UIImageView!
    @IBOutlet weak var cropTitle: UILabel!
    
//    var crop : CropVeggie
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CropDetailViewController: RMPZoomTransitionAnimating, RMPZoomTransitionDelegate {
    
    func transitionSourceImageView() -> UIImageView! {

        let imgView = UIImageView(image: self.cropImgView!.image)
        imgView.contentMode = self.cropImgView!.contentMode
        imgView.clipsToBounds = true
        imgView.isUserInteractionEnabled = false
        imgView.frame = self.cropImgView!.frame
        
        return imgView
    }
    
    func transitionSourceBackgroundColor() -> UIColor! {
       
        return self.view.backgroundColor;
    }
    
    func transitionDestinationImageViewFrame() -> CGRect {
        

//        let width = self.view.frame.width
        var frame = self.cropImgView.frame
        frame.size.width = self.view.frame.width
        
        return frame
    }
    
    func zoomTransitionAnimator(_ animator: RMPZoomTransitionAnimator!, didCompleteTransition didComplete: Bool, animatingSourceImageView imageView: UIImageView!) {
        
        self.cropImgView.image = imageView.image
    }
}
