//
//  Macros.swift
//  Vegarden
//
//  Created by Sarah Cleland on 4/12/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import Foundation

    
    public func getCropDetailCollectionViewFlowLayoutIn (navigationController navController:UINavigationController) -> UICollectionViewFlowLayout {
        
        let flowLayout = CropDetailsFlowLayout()
        
        var itemSize : CGSize?
        
        itemSize = navController.isNavigationBarHidden ?
            CGSize(width:screenWidth, height:screenHeight+20) : CGSize(width:screenWidth, height:screenHeight-navigationHeaderAndStatusbarHeight)
        
        
        flowLayout.itemSize = itemSize!
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 5,left: 0,bottom: 5,right: 0)
        
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

//    public func getGreetings() -> String! {
//        
//        let msg : String = "Good "
//        
//        let hour = Calendar.current.component(.hour, from: Date())
//    
//        switch hour {
//            case 6..<12  : msg = msg + "Morning"
//            case 12      : msg = msg + "Noon"
//            case 13..<17 : msg = msg + "Afternoon"
//            case 17..<22 : msg = msg + "Evening"
//            
//            default: msg = msg + "Night"
//        }
//    
//        return msg
//}
