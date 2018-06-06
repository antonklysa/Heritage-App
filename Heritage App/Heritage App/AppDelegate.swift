//
//  AppDelegate.swift
//  Heritage App
//
//  Created by Anton Klysa on 5/30/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: SelectDifficultyViewController.self))
        //self.window!.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: WinViewController.self))
        
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

