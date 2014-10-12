//
//  main.swift
//  Bootstrapping
//
//  Created by Hoon H. on 10/12/14.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

import AppKit



final class ExampleApplicationController: NSObject, NSApplicationDelegate {
	
	///	Seems fine to create AppKit UI classes before `NSApplication` object
	///	to be created starting OSX 10.10. (it was an error in OSX 10.9)
	let	window1	=	NSWindow()
	
	func applicationDidFinishLaunching(aNotification: NSNotification) {
		window1.setFrame(CGRect(x: 0, y: 0, width: 800, height: 500), display: true)
		window1.makeKeyAndOrderFront(self)
	}
	
	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}
	
}



///	When compared to Objective-C example, an `autoreleasepool`
///	is not required because Swift expected to install one automatically.
///	Anyway you can install one if you want to be defensive.
autoreleasepool { () -> () in
	let	app1		=	NSApplication.sharedApplication()	//	You need to retain the application object in stack. Otherwise it will be killed immediately.
	let	con1		=	ExampleApplicationController()		//	So do this too...
	
	app1.delegate	=	con1
	app1.run()
	
	///	DO NOT call `NSApplicationMain`. It will be handled by `NSApplication.run` method.
	//	NSApplicationMain(C_ARGC, C_ARGV)
}