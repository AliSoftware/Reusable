//
//  AppDelegate.swift
//  ReusableDemo tvOS
//
//  Created by Olivier HALLIGON on 16/02/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }
}

// Swift < 4.2 support
#if !(swift(>=4.2))
extension UIApplication {
  typealias LaunchOptionsKey = UIApplicationLaunchOptionsKey
}
#endif
