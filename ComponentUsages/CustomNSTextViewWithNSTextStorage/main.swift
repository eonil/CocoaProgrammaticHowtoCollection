//
//  main.swift
//  CustomNSTextViewWithNSTextStorage
//
//  Created by Hoon H. on 2014/12/26.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

import AppKit




///	When compared to Objective-C example, an `autoreleasepool`
///	is not required because Swift expected to install one automatically.
///	Anyway you can install one if you want to be safe.
autoreleasepool { () -> () in
	let	app1	=	NSApplication.sharedApplication()	//	You need to retain the application object in stack. Otherwise it will be killed immediately.
	let	con1	=	ExampleApplicationController()		//	So do this too...
	
	app1.delegate	=	con1
	app1.run()
	
	///	DO NOT call `NSApplicationMain`. It's handled by `NSApplication.run
	//	NSApplicationMain(C_ARGC, C_ARGV)
}