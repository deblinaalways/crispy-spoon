//
//  AppDelegate.swift
//  MusicApp
//
//  Created by Deblina Das on 24/01/18.
//  Copyright © 2018 Deblinas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = ViewController.navigate()
        return true
    }
}

