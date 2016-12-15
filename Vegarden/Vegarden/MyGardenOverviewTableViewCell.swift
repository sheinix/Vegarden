//
//  MyGardenOverviewTableViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 28/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SnapKit
import DZNEmptyDataSet

let cropRowHeight = 60

class MyGardenOverviewTableViewCell: UITableViewCell {

    var plantedCrops : [Crop] = GardenManager.shared.myPlantedCrops()!
    var cropsTableView : UITableView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
       
        setupTableView()
        
        //TODO Check if this shouldnt be added to the contentView of the cell! :/
//        self.addSubview(self.titleLabel)
        self.addSubview(self.cropsTableView!)
        
        setupConstraints()

        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    private func setupTableView() {
       
        self.cropsTableView = UITableView(frame: self.bounds, style: .plain)
        
//        self.cropsTableView?.layer.borderColor = Colors.mainColorUI.cgColor
//        self.cropsTableView?.layer.borderWidth = 0
//        self.cropsTableView?.layer.cornerRadius = UINumbericConstants.commonCornerRadius
//        self.cropsTableView?.layer.shadowOffset = CGSize(width: 0, height: -1)
//        self.cropsTableView?.layer.shadowOpacity = 2
//        self.cropsTableView?.layer.shadowRadius = 3
//        self.cropsTableView?.layer.shadowColor = UIColor.black.cgColor
        
        self.cropsTableView?.delegate = self
        self.cropsTableView?.dataSource = self
        self.cropsTableView?.separatorStyle = .singleLine
        self.cropsTableView?.separatorColor = Colors.mainColorUI
        self.cropsTableView?.separatorInset = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
        self.cropsTableView?.allowsSelection = false
        self.cropsTableView?.emptyDataSetSource = self
        self.cropsTableView?.emptyDataSetDelegate = self
        
        self.cropsTableView?.tableFooterView = UIView()
        
        self.cropsTableView?.estimatedRowHeight = CGFloat(cropRowHeight)
        self.cropsTableView?.register(MyGardenOverviewCropTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.MyGardenOverviewCropTableViewCellIdentifier)
    }
    
    private func setupConstraints() {
        
        //TODO TableView size should be resizable with the cell size!
        cropsTableView?.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}

extension MyGardenOverviewTableViewCell : UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.plantedCrops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MyGardenOverviewCropTableViewCellIdentifier , for: indexPath) as! MyGardenOverviewCropTableViewCell)
        
        let crop : Crop =  plantedCrops[indexPath.row]
        
        cell.harvestDate?.text = crop.estimatedHarvestDate.inShortFormat()
        cell.textLabel?.text = crop.name!
        cell.progressBar?.setProgress(CGFloat(crop.percentageCompleted), animated: true)
        
        //TODO Set the progressView!
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cropRowHeight)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cropRowHeight)
    }
}
extension MyGardenOverviewTableViewCell : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        
        return (UIImage(named: "NoCropsPlanted"))
        
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        
        let msg = NSMutableAttributedString(string: "Oops! No Crops Planted yet!",
                                            attributes: [NSFontAttributeName:Fonts.mainFont])
        msg.addAttribute(NSForegroundColorAttributeName,
                         value: Colors.mainColorUI,
                         range: NSRange(location:0, length:msg.length))
        
        
        return msg
        
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let text = "Choose a crop in My Crops view and plant it to see it here ! ";
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center;
        
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14),
                          NSForegroundColorAttributeName: UIColor.lightGray,
                          NSParagraphStyleAttributeName: paragraph]
        
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.white
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        
        return CGFloat(integerLiteral: 15)
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
