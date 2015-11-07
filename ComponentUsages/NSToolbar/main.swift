
//  AppDelegate.swift
//  ProgrammaticToolbarInstallation
//
//  Created by Hoon H. on 2015/06/13.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Cocoa


//	See also `/ComponentUsagesInObjectiveC/ToolbarOnWindow` example for Objective-C with more comments.

class AppDelegate: NSObject, NSApplicationDelegate, NSToolbarDelegate {

	let	_window1	=	NSWindow()
	
	//////////////////////////////////////////////////////////////////
	//
	//	IMPORTANT!
	//	----------
	//	You must provide an `identifier` string to make the 
	//	toolbar to work properly. Otherwise the toolbar just won't 
	//	work.
	//
	//////////////////////////////////////////////////////////////////
	let	_toolbar1	=	NSToolbar(identifier: "Tb1")

	func applicationDidFinishLaunching(aNotification: NSNotification) {
		
		//////////////////////////////////////////////////////////////////
		//
		//	IMPORTANT!
		//	----------
		//	You must set `NSToolbar.delegate` to a proper delegate 
		//	object BEFORE setting the toolbar to an `NSWindow`. 
		//	Otherwise toolbar won't work properly even you set it
		//	later.
		//
		//	Uncomment the commented lines to see how options works.
		//
		//////////////////////////////////////////////////////////////////
		
		//////////////////////////////////////////////////////////////////
		//	Begin of essential part.
		//////////////////////////////////////////////////////////////////
		_toolbar1.delegate	=	self
//		_toolbar1.displayMode	=	NSToolbarDisplayMode.LabelOnly
//		_toolbar1.sizeMode	=	NSToolbarSizeMode.Small
		_window1.toolbar	=	_toolbar1
		//////////////////////////////////////////////////////////////////
		//	End of essential part.
		//////////////////////////////////////////////////////////////////
		
		_window1.makeKeyAndOrderFront(self)
		_window1.setFrame(CGRect(x: 200, y: 300, width: 400, height: 300), display: true)
	}

	
	//////////////////////////////////////////////////////////////////
	//	Begin of essential part.
	//////////////////////////////////////////////////////////////////
	@objc
	func toolbar(toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: String, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
		let	item1		=	NSToolbarItem(itemIdentifier: itemIdentifier)
		item1.label		=	"Custom Item 1"
		item1.paletteLabel	=	"Custom Item 1 Palette Label"
		item1.target		=	self
		item1.action		=	"aaa:"
		return	item1
	}
	@objc
	func toolbarDefaultItemIdentifiers(toolbar: NSToolbar) -> [String] {
		return	[NSToolbarPrintItemIdentifier, "AAA"]
	}
	@objc
	func toolbarAllowedItemIdentifiers(toolbar: NSToolbar) -> [String] {
		return	[NSToolbarPrintItemIdentifier, "AAA"]
	}
//	@objc
//	func toolbarSelectableItemIdentifiers(toolbar: NSToolbar) -> [AnyObject] {
//		return	[NSToolbarPrintItemIdentifier, "AAA"]
//	}
	//////////////////////////////////////////////////////////////////
	//	End of essential part.
	//////////////////////////////////////////////////////////////////
	
	func aaa(_: AnyObject?) {
		print("OK!")
	}
}





//	Bootstrapping.
let	del	=	AppDelegate()
NSApplication.sharedApplication().delegate	=	del
NSApplication.sharedApplication().run()




