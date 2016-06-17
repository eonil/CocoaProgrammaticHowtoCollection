//
//  AppDelegate.swift
//  AutoLayoutWithStackViewAndScrollView
//
//  Created by Hoon H. on 2016/06/18.
//  Copyright © 2016 Eonil. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    private let mainWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
    private let exampleViewController = ExampleViewController()
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        mainWindow.screen = UIScreen.mainScreen()
        mainWindow.makeKeyAndVisible()
        mainWindow.rootViewController = exampleViewController
        return true
    }
}

