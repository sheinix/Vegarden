//
//  AppDelegate.swift
//  Vegarden
//
//  Created by Juan Nuvreni on 9/20/16.
//  Copyright © 2016 Juan Nuvreni. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        
        splitViewController.minimumPrimaryColumnWidth = UINumbericConstants.minimumWidthSideMenu
        splitViewController.maximumPrimaryColumnWidth = UINumbericConstants.maximumwidthSideMenu
        splitViewController.preferredPrimaryColumnWidthFraction = UINumbericConstants.widthSideMenu
        splitViewController.delegate = self
    
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        
        
        //Setup the persistance stack with MagicalRecord:
        PersistenceManager.shared.setupPersistanceStack()
        
        //Setup the GardenManager as the call back delegate for the PersistanceManagaer:
        PersistenceManager.shared.callBackDelegate? = GardenManager.shared
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        PersistenceManager.shared.saveContext()
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        PersistenceManager.shared.saveContext()
    }

    // MARK: - Split view
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard (secondaryAsNavController.topViewController) != nil else { return false }
//  /      if topAsDetailController.detailItem == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
//            return true
//       ` }
        return false
    }
    
}

