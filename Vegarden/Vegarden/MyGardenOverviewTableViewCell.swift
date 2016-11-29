//
//  MyGardenOverviewTableViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 28/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SnapKit

let cropRowHeight = 50

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
        
        self.cropsTableView?.layer.borderColor = UIColor.lightGray.cgColor
        self.cropsTableView?.layer.borderWidth = 1
//        self.cropsTableView?.layer.shadowOffset = CGSize(width: -, height: 1)
        self.cropsTableView?.layer.shadowOpacity = 2
        self.cropsTableView?.layer.shadowRadius = 3
        self.cropsTableView?.layer.shadowColor = UIColor.black.cgColor
        
        self.cropsTableView?.delegate = self
        self.cropsTableView?.dataSource = self
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
        
        cell.harvestDate?.text = crop.getEstimatedHarvestDate()?.inCellDateFormat()
        cell.textLabel?.text = crop.name!
        
        
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
