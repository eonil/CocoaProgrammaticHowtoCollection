//
//  ExampleApplicationController.swift
//  Bootstrapping
//
//  Created by Hoon H. on 10/12/14.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

import Cocoa

class ExampleApplicationController: NSObject, NSApplicationDelegate {

	///	Seems fine to create AppKit UI classes before `NSApplication` object
	///	to be created starting OSX 10.10. (it was an error in OSX 10.9)
	
	let	window1	=	NSWindow()

	func applicationDidFinishLaunching(aNotification: NSNotification) {
		window1.styleMask		|=	NSResizableWindowMask
		window1.setFrame(CGRect(x: 0, y: 0, width: 800, height: 500), display: true)
		window1.makeKeyAndOrderFront(self)
	}

	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}
	
}

