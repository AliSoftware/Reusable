//
//  AppDelegate.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 19/01/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
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

/// Swift < 4.2 support
#if !(swift(>=4.2))
extension UIApplication {
  typealias LaunchOptionsKey = UIApplicationLaunchOptionsKey
}
#endif