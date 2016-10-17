//
//  VCropDetailPageViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 16/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class VCropDetailPageViewCell: UICollectionViewCell {
    
    var image : UIImage?
    var pullAction : ((_ offset : CGPoint) -> Void)?
    var tappedAction : (() -> Void)?
    let tableView = UITableView(frame: screenBounds, style: UITableViewStyle.plain)
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        
        contentView.addSubview(tableView)
        tableView.register(VCropDetailPageTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.CropDetailTableViewCellIdentify)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.reloadData()
    }
    
    
}

extension VCropDetailPageViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.CropDetailTableViewCellIdentify) as! VCropDetailPageTableViewCell!
        
        cell?.imageView?.image = nil
        cell?.textLabel?.text = nil
       
        if indexPath.row == 0 {
//            let image = self.image
            cell?.imageView?.image = self.image
            cell?.imageView?.layer.cornerRadius = 10
            
        }else{
            cell?.textLabel?.text = "try pull to pop view controller 😃"
        }
       
        cell?.setNeedsLayout()
       
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        var cellHeight : CGFloat = navigationHeight
        
        if indexPath.row == 0{
        
            let imageHeight = (self.image?.size.height)!*screenWidth/(self.image?.size.width)!
            cellHeight = imageHeight
        }
        
        return cellHeight
    }
    
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        tappedAction?()
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView : UIScrollView){
        
        if scrollView.contentOffset.y < navigationHeight{
            pullAction?(scrollView.contentOffset)
        }
    }
    
}
