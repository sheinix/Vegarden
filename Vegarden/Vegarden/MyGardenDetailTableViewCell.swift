//
//  MyGardenDetailTableViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 28/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import Snapkit

class MyGardenDetailTableViewCell: UITableViewCell {
    
    let patchs : [Paddock] = (GardenManager.shared.getMyGarden().paddocks?.allObjects as! [Paddock])
    var myGardenCollectionView : UICollectionView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        
        self.myGardenCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        self.myGardenCollectionView?.delegate = self
        self.myGardenCollectionView?.dataSource = self
        
        self.addSubview(self.myGardenCollectionView)
        
        self.myGardenCollectionView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview().offset(5)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension MyGardenDetailTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return patchs.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.MyGardenDeteailCollectionCellIdentifier, for: indexPath) as! MyGardenDetailCollectionViewCell)
        
        cell.patch = patchs[indexPath.row]
        
        return cell
        
    }
    

    
}

extension MyGardenDetailTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.bounds.width / patchs.count) - 10
        
        return CGSize(width: width, height: 300)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    
    
}
