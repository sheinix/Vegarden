//
//  VCropDetailPageViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 16/10/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SCLAlertView

protocol RemoveCropButtonDelegate : class {
    func didPressRemoveCropBttn(crop: Crop)
}

class VCropDetailPageViewCell: UICollectionViewCell {
    
    var cropTitle    = UILabel(frame:CGRect(x:0,y:0, width:200, height:90))
    var statusButton = UIButton(type: .custom)
    var removeButton = UIButton(type: .custom)
    
    weak var delegate : RemoveCropButtonDelegate?
    
    public var myContext = arc4random_uniform(100) //For KVO purposes, new way to do it in Apple Docs!
    
    var crop : Crop? {
        
        didSet {
            addObserverFromCrop()
        }
    }
    
    var image : UIImage?
    var pullAction : ((_ offset : CGPoint) -> Void)?
    var tappedAction : (() -> Void)?
    var tableView : UITableView?
    
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
    }
    
    override func prepareForReuse() {
     
        super.prepareForReuse()
        tableView?.reloadData()
    }
    
    fileprivate func removeObserverFromCrop() {
        
        if self.crop != nil {
            
            self.crop?.removeObserver(self, forKeyPath: "owned", context: &myContext)
        
        }
    }
    
    fileprivate func addObserverFromCrop() {

        if self.crop != nil  {

            self.crop?.addObserver(self,
                                       forKeyPath: "owned",
                                       options: NSKeyValueObservingOptions.new,
                                       context: &myContext)
        }
    }

    private func setupContent() {
        
        backgroundColor = UIColor.clear

        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 8
        
        cropTitle.backgroundColor           = UIColor.clear
        cropTitle.textColor                 = UIColor.white
        cropTitle.font                      = Fonts.detailCropFont
        cropTitle.adjustsFontSizeToFitWidth = true
        cropTitle.layer.shadowOffset        = CGSize(width: -1, height: -1)
        cropTitle.layer.shadowOpacity       = 1
        cropTitle.layer.shadowRadius        = 6
        cropTitle.layer.shadowColor = UIColor.black.cgColor
        
        statusButton.frame = CGRect(x:0,y:0, width:100, height:40)
        statusButton.setClearStyledButton()
        statusButton.applyShadows()
        
        tableView                  = UITableView(frame:self.bounds, style: UITableViewStyle.plain)
        tableView?.separatorStyle  = .none
        tableView?.allowsSelection = false
        tableView?.delegate        = self
        tableView?.dataSource = self
        tableView?.register(VCropDetailPageTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.CropDetailTableViewCellIdentify)
        
        contentView.addSubview(tableView!)
        
//        let animationPoint = CGPoint(x: (self.contentView.frame.width/2)-250, y:(self.frame.size.height/2)-250)
//        InstructionsManager.shared.animate(gesture: .swipeDown, in: animationPoint, of: self.contentView)
    }

    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard context == &myContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        guard let cropie = object as? Crop else { return }
        //FIX: Doing this check because theres another instance of the cell watching the property
       // guard cropie === self.crop else { return }
        
        self.showConfirmViewWith(title: cropie.name! +  (cropie.owned ? " Added !" : "  Removed!"),
                                 frame: screenBounds,
                                 afterAction: {
                                    self.pullAction!((self.tableView?.contentOffset)!) })
        

    }

    @objc func cropPlanted(notification: Notification) {
        
        guard let crop = notification.userInfo?["crop"] as? Crop else { return }
        
        //This time I need to compare names, because wont be same instance, as I copy the obj to plant!
        if (self.crop?.name != crop.name) { return }
     
        self.showConfirmViewWith(title: crop.name! + " Planted! ",
                                 frame: screenBounds,
                                 afterAction: { self.pullAction!((self.tableView?.contentOffset)!) })
    }
    
    deinit {
        
        removeObserverFromCrop()
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addObserversForCropActions() {

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
        
//        let cellId = (indexPath.row == 0 ? CellIdentifiers.CropDetailViewCellImageIdentify :
//                                           CellIdentifiers.CropDetailTableViewCellIdentify)
        
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
            
            cell?.setupCropInfoWith(crop: self.crop!)
        
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return (indexPath.row == 0 ? (self.image?.size.height)!*screenWidth/(self.image?.size.width)! :
                UITableViewAutomaticDimension)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
       // var cellHeight : CGFloat = navigationHeight
        let imageHeight = (self.image?.size.height)!*screenWidth/(self.image?.size.width)!
        
        if indexPath.row == 0 {

            //cellHeight = imageHeight
            
            return imageHeight
        }
        
     //   cellHeight = tableView.frame.height - imageHeight
        
        return 1050//cellHeight
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
        
        if (sender.titleLabel?.text == "Plant") { showPlantAlertView() }
        else {
                if let newCrop = self.crop { GardenManager.shared.addNewCropToGarden(crop: newCrop) }
        }
    }
    
    fileprivate func showPlantAlertView() {
        
        let appearance = Appereance().appereanceForAlert(frame: self.bounds,
                                                         color: Colors.plantColor,
                                                    needsTitle: false)
        
        
        let alert = ActionMenuAlertView(appearance: appearance,
                                        crop: self.crop!,
                                        action: nil,
                                        isPlanting: true,
                                        and: .Row)
        
        let _ = alert.showInfo("",
                               subTitle: "",//"Plant " + self.crop!.name!,
                               closeButtonTitle: "Close",
                               duration: 0,
                               colorStyle: Colors.plantColorHex,
                               colorTextButton: 0xFFFFFF,
                               animationStyle: .topToBottom)

    }
    
    
    fileprivate func createFooterView() -> UIView {

        let frame  = CGRect(x: 0,
                            y: (self.tableView?.frame.height)!,
                        width: (self.tableView?.frame.width)!,
                       height: (self.tableView?.frame.height)! * 0.1)
        
        let footerView = UIView(frame:frame)
        
        removeButton.frame = footerView.bounds
        //removeButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: -10, right: -10)
        removeButton.layer.cornerRadius = UINumbericConstants.commonCornerRadius
        removeButton.backgroundColor = UIColor.red
        removeButton.titleLabel?.textColor = UIColor.white
        removeButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        removeButton.setTitle("Remove Crop", for: .normal)
        removeButton.addTarget(self, action: #selector(removeCropPressed), for: .touchUpInside)
        
        footerView.addSubview(removeButton)
        
        removeButton.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        return footerView
    }
    
    @objc fileprivate func removeCropPressed(sender: UIButton) {
    
        guard let crop = self.crop else { return }
        
        self.delegate?.didPressRemoveCropBttn(crop: crop)
        
    }

}
