//
//  Constants.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 10/5/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import UIKit



let tableAlertViewFrame = CGRect(x: 0,
                                 y: 0,
                                width: screenBounds.width * 0.85,
                                height: screenBounds.height * 0.8)
let screenBounds = UIScreen.main.bounds
let screenSize   = screenBounds.size
let screenWidth  = screenSize.width
let screenHeight = screenSize.height
let gridWidth : CGFloat = (screenSize.width/2)-5.0
let navigationHeight : CGFloat = 44.0
let statubarHeight : CGFloat = 20.0
let navigationHeaderAndStatusbarHeight : CGFloat = navigationHeight + statubarHeight
let isLandscape = UIApplication.shared.statusBarOrientation.isLandscape

struct Colors {
    static let mainColor = UIColor(red: 121/255, green: 178/255, blue: 159/255, alpha: 0.9).cgColor
    static let mainColorUI = UIColor(cgColor: mainColor)
    static let greetingsHeaderColor =  UIColor(red: 57/255, green: 145/255, blue: 233/255, alpha: 0.9)
}

struct Fonts {
    static let mainFont : UIFont = UIFont(name: "OpenSans-Light", size: 26)!
    static let detailCropFont : UIFont = UIFont(name: "GillSans", size: 80)!
    static let emptyStateFont : UIFont = UIFont(name: "OpenSans-Light", size: 46)!
    
    
    static let appleGoticUltraLightFont : UIFont = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 28)!
    
    static let cropInfoLabelFont : UIFont = UIFont(name: "Avenir-Light", size: 15)!
}

struct UINumbericConstants {
    static let widthSideMenu : CGFloat = 0.2
    static let minimumWidthSideMenu : CGFloat = 120
    static let maximumwidthSideMenu : CGFloat = 220
    static let floatingBttnSize : CGFloat = 100
    static let floattingBttnCGSize : CGSize = CGSize(width:floatingBttnSize, height:floatingBttnSize)
    static let commonCornerRadius : CGFloat = 10
}

struct CellIdentifiers {
    static let sideTabCellIdentifier = "SideTabScreenCellIdentifier"
    static let CropDetailViewCellIdentify = "CropDetailViewCellIdentify"
    static let CropDetailTableViewCellIdentify = "CropDetailTableViewCellIdentify"
    static let CropListTableViewCellIdentify = "CropListTableViewCellIdentify"
    static let lifeCycleTableViewCellIdentifier = "FoldingCell"
    static let lifeCycleDetailViewCellIdentifier = "lifeCycleDetailViewCellIdentifier"
    static let DetailPatchRowTableViewCellIdentifier = "DetailPatchRowTableViewCellIdentifier"
    
    static let MyGardenOverviewCellIdentifier = "MyGardenOverviewCellIdentifier"
    static let MyGardenDetailCellIdentifier = "MyGardenDetailCellIdentifier"
    static let MyGardenOverviewCropTableViewCellIdentifier = "MyGardenOverviewCropTableViewCellIdentifier"
    
    static let MyGardenDeteailCollectionCellIdentifier = "MyGardenDeteailCollectionCellIdentifier"
    
    static let PatchEditionCellIdentifier = "PatchEditionCellIdentifier"
    static let RowsEditionCellIdentifier = "RowsEditionCellIdentifier"
}

struct FontSizes {
    static let Large: CGFloat = 14.0
    static let Small: CGFloat = 10.0
}

struct MainViews {
    static let MyCropsView: String = "My Crops"
    static let DataBaseView: String = "Database"
    static let LifeCycleView: String = "LifeCylce"
    static let MyGardenView: String = "My Garden"
    static let AboutView: String = "About"
}

struct SegueIdentifiers {
    static let showMyCropsView = "showMyCropsView"
    static let showDataBaseView = "showDataBaseView"
    static let showMyGardenView = "showMyGardenView"
    static let showLifeCycleView = "showLifeCycleView"
    static let showAboutView = "showAboutView"
    
//    static let Detail = "DetailViewController"
}

struct FileNames {
    static let allCropsFileName = "AllCrops"
}

public enum CropTypes: Int16 {
    case Annual, Perenneal, Tuba
}

public enum plantingStates: Int {
    
            case Seed, Seedling, Planted, Growing, Grown, Harvested
}

public enum GrowingActions: Int {
     case WeedAction, WaterAction, FertilizeAction, HarvestAction, FinishAction, UnplantAction
}

enum TimeLapses {
    
    case Days, Weeks, Months 
}

enum ActionUnits {
    case Patch, Row, Garden
}

public struct lifeCyclceSates {
    static let Seed = "Seed"
    static let Seedling = "Seedling"
    static let Growig = "Growing"
    static let Harvesting = "Harvesting"
    static let Finish = "Finish"
    
}

public struct MyCropsSectionTitles {
    static let OwnedCrops = "Owned Crops"
    static let StockCrops = "Stock Crops"
}

public enum MyCropsSection : Int {
    
    case OwnedCrops, StockCrops
}

public enum FinishReason : Int {
    
    case CropWasted, FinishHarvesting
}

