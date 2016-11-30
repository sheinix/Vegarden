//
//  MyGardenDetailTableViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 28/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SnapKit
import KCFloatingActionButton
import SCLAlertView

class MyGardenDetailTableViewCell: UITableViewCell {
    
    var actionMenu : KCFloatingActionButton?
    var myGardenCollectionView : UICollectionView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        
        let layout = UICollectionViewFlowLayout()
        
        self.myGardenCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)

        if let myGardenCV = self.myGardenCollectionView {
            
            myGardenCV.register(MyGardenDetailCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifiers.MyGardenDeteailCollectionCellIdentifier)
            
            myGardenCV.backgroundColor = UIColor.white
            
            self.addSubview(myGardenCV)
        }
        
        self.myGardenCollectionView?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        })
        
        setupFloatingButton()
        
        
        
        super.awakeFromNib()
        
    }
    
    fileprivate func setupFloatingButton() {
    
        actionMenu = KCFloatingActionButton()
        
        guard let actionMenu = actionMenu else { return }
        
        actionMenu.openAnimationType = KCFABOpenAnimationType.pop
        actionMenu.openingAnimationDirection = KCFABOpeningAnimationDirection.Vertical
    
        self.addSubview(actionMenu)
    
        actionMenu.addItem("Add New Patch", icon: UIImage(named:"icon_fertilize")) { (item) in
    
            self.showAddEditView()
        }
    }
    
    fileprivate func showAddEditView() {
        
        let appearance = SCLAlertView.SCLAppearance(kWindowWidth: screenWidth * 0.9,
                                                    kWindowHeight: screenHeight * 0.9,
                                                    showCloseButton: true)
        
        let view = PatchAddEditViewController(appearance:appearance , patch: nil)
  
        
        let _ = view.showEdit("Add New Patch", subTitle: "")
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
