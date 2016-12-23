//
//  AboutViewController.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 10/2/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var rateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func rateApp(_ sender: Any) {
        
        //TODO Get the app id!
        rateApplication(appId: "", completion: {_ in } )
    }
}
