//
//  ApplicationController.swift
//  cam1
//
//  Created by Hoon H. on 2015/02/17.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import UIKit

@UIApplicationMain
class ApplicationController: UIResponder, UIApplicationDelegate {
	
	var window	=	UIWindow(frame: UIScreen.mainScreen().bounds) as UIWindow?
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		window!.rootViewController	=	ExampleViewController()
		window!.makeKeyAndVisible()
		
		return true
	}
}





private class ExampleViewController: UIViewController {
	lazy var	manager	=	CameraManager()
	private override func viewDidLoad() {
		super.viewDidLoad()
		
		manager.display.frame	=	self.view.layer.bounds
		self.view.layer.addSublayer(manager.display)
	}
}














