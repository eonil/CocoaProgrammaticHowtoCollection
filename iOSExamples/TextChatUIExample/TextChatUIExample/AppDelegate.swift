//
//  AppDelegate.swift
//  ConversationUIExample
//
//  Created by Hoon H. on 2015/11/28.
//  Copyright © 2015 Eonil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	// MARK: -
	override init() {
		KeyboardFrameTrackingController.initiate()
		_mainWindow	=	UIWindow(frame: UIScreen.mainScreen().bounds)
		_nc1		=	UINavigationController()
		_vc1		=	UIViewController()
		super.init()
	}
	deinit {
		KeyboardFrameTrackingController.terminate()
	}

	// MARK: -
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		_mainWindow.makeKeyAndVisible()
		_mainWindow.rootViewController	=	_nc1
		_nc1.pushViewController(_vc1, animated: false)
		_vc1.navigationItem.rightBarButtonItem	=	UIBarButtonItem(title: "VC2", style: UIBarButtonItemStyle.Plain, target: self, action: "EDITOR_test1:")
		return true
	}

	// MARK: -
	@objc
	func EDITOR_test1(_: AnyObject?) {
		let	vc	=	ViewController2()
		_nc1.pushViewController(vc, animated: true)
	}

	// MARK: -
	private let	_mainWindow	:	UIWindow
	private let	_nc1		:	UINavigationController
	private let	_vc1		:	UIViewController

}

