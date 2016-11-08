//
//  VCropDetailPageViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 16/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit

class VCropDetailPageViewCell: UICollectionViewCell {
    
    var cropTitle = UILabel(frame:CGRect(x:0,y:0, width:200, height:90))
    var statusButton = UIButton(type: .custom)
    var crop : Crop?
    
    var image : UIImage?
    var pullAction : ((_ offset : CGPoint) -> Void)?
    var tappedAction : (() -> Void)?
    let tableView = UITableView(frame: screenBounds, style: UITableViewStyle.plain)
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
        cropTitle.backgroundColor = UIColor.clear
        cropTitle.textColor = UIColor.white
        cropTitle.font = UIFont.systemFont(ofSize: 80)
        
        statusButton.frame = CGRect(x:0,y:0, width:100, height:40)
        statusButton.backgroundColor = UIColor.clear
        statusButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        statusButton.titleLabel?.textColor = UIColor.white
        statusButton.layer.cornerRadius = 10
        statusButton.layer.borderColor = UIColor.white.cgColor
        statusButton.layer.borderWidth = 2
        
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.CropDetailTableViewCellIdentify) as! VCropDetailPageTableViewCell!
        
        cell?.imageView?.image = nil
        cell?.textLabel?.text = nil
       
        if indexPath.row == 0 {
//            let image = self.image
            cell?.imageView?.image = self.image
            cell?.imageView?.layer.cornerRadius = 10
            cell?.imageView?.isUserInteractionEnabled = true
            cell?.imageView?.addSubview(cropTitle)
            cell?.imageView?.addSubview(statusButton)
            
            let buttonTitle = ((crop?.owned)!  ? "Plant" : "Add Crop")
            statusButton.setTitle(buttonTitle, for: UIControlState.normal)
            statusButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
            
            cropTitle.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(20)
                make.bottom.equalToSuperview()
                make.height.equalTo(200)
                make.width.equalTo(400)
            }
            
            statusButton.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-20)
                make.bottom.equalTo(cropTitle.snp.bottom).offset(-50)
                make.height.equalTo(100)
                make.width.equalTo(200)
            }
            
            
        } else {
            
            cell?.setupStackedViewsWith(crop: self.crop!, and: tableView.frame)
        }
       
        cell?.setNeedsLayout()
       
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        var cellHeight : CGFloat = navigationHeight
        let imageHeight = (self.image?.size.height)!*screenWidth/(self.image?.size.width)!
        
        if indexPath.row == 0{

            //cellHeight = imageHeight
            
            return imageHeight
        }
        
        cellHeight = tableView.frame.height - imageHeight
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        tappedAction?()
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView : UIScrollView){
        
        if scrollView.contentOffset.y < navigationHeight{
            pullAction?(scrollView.contentOffset)
        }
    }
    
    @objc fileprivate func actionButtonPressed(sender: UIButton) {
        
        if (sender.titleLabel?.text == "Plant") {
            
            print("GO TO PLANTING FLOW!")
        } else {
            
            if let newCrop = self.crop {
                
                GardenManager.shared.addNewCropToGarden(crop: newCrop)
                sender.setTitle("Plant", for: .normal)

            }
        }
        
    }
}
