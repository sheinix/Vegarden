//
//  WelcomeVegardenViewController.swift
//  Vegarden
//
//  Created by Sarah Cleland on 22/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import BWWalkthrough

class WelcomeVegardenViewController: UIViewController, BWWalkthroughPage {

    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func walkthroughDidScroll(to: CGFloat, offset: CGFloat) {
//        var tr = CATransform3DIdentity
//        tr.m34 = -1/500.0
//        
//        titleLabel?.layer.transform = CATransform3DRotate(tr, CGFloat(M_PI) * (1.0 - offset), 1, 1, 1)
//        textLabel?.layer.transform = CATransform3DRotate(tr, CGFloat(M_PI) * (1.0 - offset), 1, 1, 1)
//        
//        var tmpOffset = offset
//        if(tmpOffset > 1.0){
//            tmpOffset = 1.0 + (1.0 - tmpOffset)
//        }
//        imageView?.layer.transform = CATransform3DTranslate(tr, 0 , (1.0 - tmpOffset) * 200, 0)
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
