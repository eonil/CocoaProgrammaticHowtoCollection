//
//  AppDelegate.swift
//  UICollectionViewCustomLayout
//
//  Created by Hoon H. on 2015/11/28.
//  Copyright © 2015 Eonil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		_mainWindow.makeKeyAndVisible()
		_mainWindow.rootViewController	=	_vc1
		return true
	}

	private let	_mainWindow	=	UIWindow(frame: UIScreen.mainScreen().bounds)
	private let	_vc1		=	ViewController1(collectionViewLayout: Layout1())
}

