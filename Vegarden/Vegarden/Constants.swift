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
let screenCenter = CGPoint(x: screenWidth/2, y: screenHeight/2)
let gridWidth : CGFloat = (screenSize.width/2)-5.0
let navigationHeight : CGFloat = 44.0
let statubarHeight : CGFloat = 20.0
let navigationHeaderAndStatusbarHeight : CGFloat = navigationHeight + statubarHeight
let isLandscape = UIApplication.shared.statusBarOrientation.isLandscape
let facebookURL = URL(string: "https://www.facebook.com/akiwiandagaucho/")!
let appVersion = String(describing: (Bundle.main.infoDictionary!["CFBundleShortVersionString"]!))

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
    
    static let AboutInoCellIdentifier = "AboutInoCellIdentifier"
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
    static let Planted = "Planted"
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

public struct UserDefaultsKeys {
    static let userNameKey = "userName"
    static let walkthroughKey = "walkthroughPresented"
}
