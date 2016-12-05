//
//  VCropDetailPageViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 16/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SCLAlertView

class VCropDetailPageViewCell: UICollectionViewCell {
    
    var cropTitle = UILabel(frame:CGRect(x:0,y:0, width:200, height:90))
    var statusButton = UIButton(type: .custom)
    var removeButton = UIButton(type: .custom)
    var crop : Crop?
    var image : UIImage?
    var pullAction : ((_ offset : CGPoint) -> Void)?
    var tappedAction : (() -> Void)?
    let tableView = UITableView(frame: screenBounds, style: UITableViewStyle.plain)
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupContent()
        
        addObserversForCropActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.reloadData()
    }
    
    private func setupContent() {
        
        backgroundColor = UIColor.clear

        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 8
        
        cropTitle.backgroundColor = UIColor.clear
        cropTitle.textColor = UIColor.white
        cropTitle.font = Fonts.detailCropFont
        cropTitle.adjustsFontSizeToFitWidth = true
        cropTitle.layer.shadowOffset = CGSize(width: -1, height: -1)
        cropTitle.layer.shadowOpacity = 1
        cropTitle.layer.shadowRadius = 6
        cropTitle.layer.shadowColor = UIColor.black.cgColor
        
        statusButton.frame = CGRect(x:0,y:0, width:100, height:40)
        statusButton.setClearStyledButton()
        statusButton.applyShadows()
        
        contentView.addSubview(tableView)
        tableView.register(VCropDetailPageTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.CropDetailTableViewCellIdentify)
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    @objc func cropRemoved(notification: Notification) {
        
        let infoCrop = (notification.userInfo?["crop"] as! Crop)
      
        if (infoCrop === self.crop!) {

            let msg = infoCrop.name! +  " Crop Removed ! "
            self.showConfirmViewWith(title: msg,
                                     frame: screenBounds,
                                     afterAction: { self.pullAction!(self.tableView.contentOffset) })
        }
    }
    
    
    @objc func cropAdded(notification: Notification) {
        
        let infoCrop = (notification.userInfo?["crop"] as! Crop)
        
        if (infoCrop === self.crop!) {

                let msg = infoCrop.name! +  " Crop Added ! "
            
            self.showConfirmViewWith(title: msg,
                                     frame: screenBounds,
                                     afterAction: { self.pullAction!(self.tableView.contentOffset) })
        }
    }
    
    @objc func cropPlanted(notification: Notification) {
        
            let plantMsg = (notification.userInfo?["crop"] as! Crop).name! + " Planted! "
        
        self.showConfirmViewWith(title: plantMsg,
                                 frame: screenBounds,
                                 afterAction: { self.pullAction!(self.tableView.contentOffset) })

    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addObserversForCropActions() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(cropRemoved),
                                               name: NSNotification.Name(rawValue: NotificationIds.NotiKeyCropRemoved),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(cropAdded),
                                               name: NSNotification.Name(rawValue: NotificationIds.NotiKeyCropAdded),
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(cropPlanted),
                                               name: NSNotification.Name(rawValue: NotificationIds.NotiKeyCropPlanted),
                                               object: nil)
        

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
        
            cell?.imageView?.image = self.image
      
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
            
            
        } else if indexPath.row == 1 {
            
            cell?.setupStackedViewsWith(crop: self.crop!, and: tableView.frame)
        
        }
        
        cell?.setNeedsLayout()
        
        //Add the selector here, when i have the crop setted
        
        if (self.crop!.owned && tableView.tableFooterView == nil) {

            tableView.tableFooterView = createFooterView()
            tableView.bringSubview(toFront: tableView.tableFooterView!)
        }
        
//        guard (removeButton.target(forAction: #selector(removeCropPressed), withSender: self) != nil) else {
//            removeButton.addTarget(self, action: #selector(removeCropPressed), for: .touchUpInside)
//            
//            return cell!
//        }
        
       
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        var cellHeight : CGFloat = navigationHeight
        let imageHeight = (self.image?.size.height)!*screenWidth/(self.image?.size.width)!
        
        if indexPath.row == 0 {

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
            
            let appearance = SCLAlertView.SCLAppearance(kWindowWidth: screenWidth * 0.9,
                                                        kWindowHeight: screenHeight * 0.9,
                                                        showCloseButton: true)
            
            let alert = ActionMenuAlertView(appearance: appearance,
                                            crop: self.crop!,
                                            action: nil,
                                            isPlanting: true,
                                            and: .Row)
            
            let _ = alert.showCustom("Plant",
                             subTitle: (self.crop?.name)!,
                             color: UIColor.green,
                             icon: UIImage(named:"icon_weeding")!)

            
        } else {
            
            if let newCrop = self.crop {
                
                GardenManager.shared.addNewCropToGarden(crop: newCrop)

            }
        }
        
    }
    
    fileprivate func createFooterView() -> UIView {
        
        let height = self.tableView.frame.height * 0.1
        let frame  = CGRect(x: 0,
                            y: self.tableView.frame.height,
                        width: self.tableView.frame.width,
                       height: height)
        
        let footerView = UIView(frame:frame)
        
        removeButton.frame = footerView.bounds
        removeButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        removeButton.layer.cornerRadius = 14
        removeButton.backgroundColor = UIColor.red
        removeButton.titleLabel?.textColor = UIColor.white
        removeButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        removeButton.setTitle("Remove Crop", for: .normal)
        removeButton.addTarget(self, action: #selector(removeCropPressed), for: .touchUpInside)
        
        footerView.addSubview(removeButton)
        
        removeButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
        
        return footerView
    }
    
    @objc fileprivate func removeCropPressed(sender: UIButton) {
    
        if self.crop != nil {
            
            GardenManager.shared.removeCropFromGarden(crop: self.crop!)
        }
    }

    
    
}
