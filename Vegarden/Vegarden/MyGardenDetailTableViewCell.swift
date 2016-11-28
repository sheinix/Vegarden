//
//  MyGardenDetailTableViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 28/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SnapKit

class MyGardenDetailTableViewCell: UITableViewCell {
    
    let patchs : [Paddock] = (GardenManager.shared.getMyGarden().paddocks?.allObjects as! [Paddock])
    var myGardenCollectionView : UICollectionView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
           }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        
        self.backgroundColor = UIColor.gray
        
        let layout = UICollectionViewFlowLayout()
        
        self.myGardenCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)

        if let myGardenCV = self.myGardenCollectionView {
            myGardenCV.delegate = self
            myGardenCV.dataSource = self
            myGardenCV.register(MyGardenDetailCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifiers.MyGardenDeteailCollectionCellIdentifier)
            self.addSubview(myGardenCV)
        }
        
        
        self.myGardenCollectionView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview().offset(5)
        })
        

        
        super.awakeFromNib()
        
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
        
        let width = (Int(self.bounds.width) / patchs.count) - 10
        
        return CGSize(width: width, height: 300)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(integerLiteral: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(integerLiteral: 10)
    }
    
    
    
}
