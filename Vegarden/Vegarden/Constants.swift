//
//  Constants.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 10/5/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView

let screenBounds = UIScreen.main.bounds
let screenSize   = screenBounds.size
let screenWidth  = screenSize.width
let screenHeight = screenSize.height
let gridWidth : CGFloat = (screenSize.width/2)-5.0
let navigationHeight : CGFloat = 44.0
let statubarHeight : CGFloat = 20.0
let navigationHeaderAndStatusbarHeight : CGFloat = navigationHeight + statubarHeight
let isLandscape = UIApplication.shared.statusBarOrientation.isLandscape


struct Appereance {
    public func appereanceForAlert(frame: CGRect, color: UIColor, needsTitle: Bool) -> SCLAlertView.SCLAppearance {
       
        let appereance = SCLAlertView.SCLAppearance(kTitleTop: (needsTitle ? 40 : 0),
                                                    kTitleHeight: 28,
            kWindowWidth: frame.width*0.85,
            kTextHeight: 0,
            kTitleFont: UIFont.systemFont(ofSize: 30),
            showCloseButton: true,
            showCircularIcon: false,
            shouldAutoDismiss: true,
            contentViewCornerRadius: UINumbericConstants.commonCornerRadius,
            fieldCornerRadius: UINumbericConstants.commonCornerRadius,
            buttonCornerRadius: UINumbericConstants.commonCornerRadius,
            hideWhenBackgroundViewIsTapped: false,
            contentViewBorderColor: UIColor.clear,
            titleColor: color)
        
        return appereance
    }
    
//    public func appereanceForAlertPatch(frame: CGrect, color: UIColor) -> SCLAlertView.SCLAppearance {
//        
//        SCLAlertView.SCLAppearance(kWindowWidth: screenWidth * 0.85,
//                                   kWindowHeight: screenHeight * 0.85,
//                                   showCloseButton: true,
//                                   showCircularIcon: false)
    
//    }
    
    
}


struct Colors {
    static let mainColor = UIColor(red: 121/255, green: 178/255, blue: 159/255, alpha: 0.9).cgColor
    static let mainColorUI = UIColor(cgColor: mainColor)
    static let greetingsHeaderColor =  UIColor(red: 57/255, green: 145/255, blue: 233/255, alpha: 0.9)
    
    
    static let mainColorHex : UInt  = 0x79b29f
    
    static let plantColorHex : UInt     = 0x9CD085
    static let plantColor : UIColor = UIColor(netHex: Int(plantColorHex))
    
    static let waterColorHex : UInt     = 0x85BAC5
    static let waterColor : UIColor = UIColor(netHex: Int(waterColorHex))
    
    static let weedColorHex  : UInt     = 0x416531
    static let weedColor : UIColor = UIColor(netHex: Int(weedColorHex))
    
    static let fertilizeColorHex : UInt = 0xDB9B58
    static let fertilizeColor : UIColor = UIColor(netHex: Int(fertilizeColorHex))
    
    static let removeColorHex : UInt    = 0xE16565
    static let removeColor : UIColor = UIColor(netHex: Int(removeColorHex))
    
    static let harvestColorHex : UInt   = 0xD971D9
    static let harvestColor : UIColor = UIColor(netHex: Int(harvestColorHex))
    
    static let finishHarvestColorHex : UInt = 0x27639A
    static let finishHarvestColor : UIColor = UIColor(netHex: Int(finishHarvestColorHex))
    
    
    static let notesColor = UIColor(red: 243/255, green: 235/255, blue: 122/255, alpha: 0.9)
    
    
    static let headerGradient = [mainColor,
                                // UIColor(red:34/255, green:181/255, blue:235/255, alpha:0.5).cgColor,
                                 UIColor(red:41/255, green:243/255, blue: 185/255, alpha:0.3).cgColor]
                                // UIColor(red:88/255, green:199/255, blue: 140/255, alpha:0.1).cgColor,
    
//                                 UIColor(red:50.0/255, green:50.0/255, blue:50.0/255, alpha:0.1).CGColor]
    }
    

struct Fonts {
    static let mainFont : UIFont = UIFont(name: "OpenSans-Light", size: 26)!
    static let detailCropFont : UIFont = UIFont(name: "GillSans", size: 80)! //GillSans
    static let emptyStateFont : UIFont = UIFont(name: "OpenSans-Light", size: 46)!
    
    
    static let appleGoticUltraLightFont : UIFont = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 28)!
    
    static let cropInfoLabelFont : UIFont = UIFont(name: "Avenir-Light", size: 15)!
    
    static let gardenOverviewFont : UIFont = UIFont(name: "OpenSans-Light", size: 18)!
    static let sideBarFont : UIFont = UIFont(name: "OpenSans-Light", size: 20)!
    
    static let cropCellFontBig : UIFont = UIFont(name: "GillSans", size: 30)!
    static let cropCellFontSmall : UIFont = UIFont(name: "GillSans", size: 20)!
}

struct UINumbericConstants {
    static let widthSideMenu : CGFloat = 0.2
    static let minimumWidthSideMenu : CGFloat = 120
    static let maximumwidthSideMenu : CGFloat = 220
    static let floatingBttnSize : CGFloat = 100
    static let floattingBttnCGSize : CGSize = CGSize(width:floatingBttnSize, height:floatingBttnSize)
    static let commonCornerRadius : CGFloat = 9
}

struct CellIdentifiers {
    static let sideTabCellIdentifier = "SideTabScreenCellIdentifier"
    static let CropDetailViewCellIdentify = "CropDetailViewCellIdentify"
    static let CropDetailViewCellImageIdentify = "CropDetailViewCellImageIdentify"
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

public struct lifeStates {
    let lifeCycleKey : lifeCyclceSates
    var lifeState : Any
}
