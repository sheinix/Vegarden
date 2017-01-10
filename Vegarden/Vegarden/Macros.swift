//
//  Macros.swift
//  Vegarden
//
//  Created by Sarah Cleland on 4/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation

    public func rateApplication(appId: String, completion: @escaping ((_ success: Bool)->())) {
        
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            
            completion(false)
            return
        }
        
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }

    public func getCropDetailCollectionViewFlowLayoutIn (navigationController navController:UINavigationController) -> UICollectionViewFlowLayout {
        
        let flowLayout = UICollectionViewFlowLayout() //CropDetailsFlowLayout()
        
        var itemSize : CGSize?
        
        itemSize = navController.isNavigationBarHidden ?
            CGSize(width:screenWidth-20, height:screenHeight) : CGSize(width:screenWidth-20, height:screenHeight-navigationHeaderAndStatusbarHeight)
        
        
        flowLayout.itemSize = itemSize!
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        
        return flowLayout
}
    public func screenMessage(notiId: String) -> String! {
    
        var msg : String = ""
    
        switch notiId {
            
            case NotificationIds.NotiKeyNewPatch:
                msg = "New Patch Created!"
            case NotificationIds.NotiKeyPatchDeleted:
                msg = "Patch Deleted!"
            case NotificationIds.NotiKeyPatchEdited:
                msg = "Patch Edited!"
            case NotificationIds.NotiKeyRowsEdited:
                msg = "Rows Edited!"
            case NotificationIds.NotiKeyRowsAdded:
                msg = "Rows Added!"
            case NotificationIds.NotiKeyRowsDeleted:
                msg = "Rows Deleted!"
            default:
            break
        }
    
        return msg
    }
    public func colorFor(growingAction: GrowingActions!) -> (UIColor?, UInt?) {
    
        var color : (UIColor?, UInt?)
    
        switch growingAction! {
            
            case GrowingActions.FertilizeAction:
                
                 color = (Colors.fertilizeColor, Colors.fertilizeColorHex)
            
            case GrowingActions.WaterAction:
            
                color = (Colors.waterColor, Colors.waterColorHex)
            
            case GrowingActions.WeedAction:
            
                color = (Colors.weedColor, Colors.weedColorHex)
            
            case GrowingActions.HarvestAction:
            
                color = (Colors.harvestColor, Colors.harvestColorHex)
            
            case GrowingActions.FinishAction:
            
                color = (Colors.finishHarvestColor, Colors.finishHarvestColorHex)
            
            case GrowingActions.UnplantAction:
            
                color = (Colors.removeColor, Colors.removeColorHex)
        }

        return color
}
