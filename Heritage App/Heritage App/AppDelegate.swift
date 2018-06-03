//
//  AppDelegate.swift
//  Heritage App
//
//  Created by Anton Klysa on 5/30/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let shouldLogin : Bool = PMISessionManager.defaultManager.hostessId == nil
        if (shouldLogin) {
            self.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: SelectCampaignViewController.self))
        } else {
            self.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: SelectDifficultyViewController.self))
        }
        
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

