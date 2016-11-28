//
//  MyGardenOverviewTableViewCell.swift
//  Vegarden
//
//  Created by Sarah Cleland on 28/11/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import SnapKit

class MyGardenOverviewTableViewCell: UITableViewCell {

    var plantedCrops : [Crop] = GardenManager.shared.myPlantedCrops()!
    
    var titleLabel : UILabel = UILabel()
    var cropsTableView : UITableView?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
       
        self.cropsTableView = UITableView(frame: self.bounds, style: .plain)
        self.backgroundColor = UIColor.green
        
        self.cropsTableView?.delegate = self
        self.cropsTableView?.dataSource = self
        self.cropsTableView?.register(MyGardenOverviewCropTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.MyGardenOverviewCropTableViewCellIdentifier)
        
//        self.titleLabel.font = Fonts.mainFont
//        self.titleLabel.text = "Overview | Crops Planted : " + String(self.plantedCrops.count)
        
        //TODO Check if this shouldnt be added to the contentView of the cell! :/
//        self.addSubview(self.titleLabel)
        self.addSubview(self.cropsTableView!)
        
        setupConstraints()

        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    private func setupConstraints() {
        
//        titleLabel.snp.makeConstraints { (make) in
//            make.leading.equalTo(self.snp.leading).offset(10)
//            make.trailing.equalTo(self.snp.trailing).offset(-10)
//            make.top.equalToSuperview().offset(5)
//            make.height.equalTo(40)
//        }
        
        //TODO TableView size should be resizable with the cell size!
        cropsTableView?.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
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
}
