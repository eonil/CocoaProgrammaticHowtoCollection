//
//  main.swift
//  ApplicationMenu
//
//  Created by Hoon H. on 2015/11/07.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Cocoa


class AppDelegate: NSObject, NSApplicationDelegate {

	func applicationDidFinishLaunching(aNotification: NSNotification) {

		let	mainMenu		=	NSMenu()									//	`title` really doesn't matter.
		let	mainAppMenuItem		=	NSMenuItem(title: "Application", action: nil, keyEquivalent: "")		//	`title` really doesn't matter.
		let	mainFileMenuItem	=	NSMenuItem(title: "File", action: nil, keyEquivalent: "")
		mainMenu.addItem(mainAppMenuItem)
		mainMenu.addItem(mainFileMenuItem)

		let	appMenu			=	NSMenu()									//	`title` really doesn't matter.
		mainAppMenuItem.submenu		=	appMenu

		let	appServicesMenu		=	NSMenu()
		NSApp.servicesMenu		=	appServicesMenu
		appMenu.addItemWithTitle("About Me", action: nil, keyEquivalent: "")
		appMenu.addItem(NSMenuItem.separatorItem())
		appMenu.addItemWithTitle("Preferences...", action: nil, keyEquivalent: ",")
		appMenu.addItem(NSMenuItem.separatorItem())
		appMenu.addItemWithTitle("Hide Me", action: "hide:", keyEquivalent: "h")
		appMenu.addItem({ ()->NSMenuItem in
			let m	=	NSMenuItem(title: "Hide Others", action: "hideOtherApplications:", keyEquivalent: "h")
			m.keyEquivalentModifierMask	=	Int(NSEventModifierFlags([.CommandKeyMask, .AlternateKeyMask]).rawValue)
			return	m
			}())
		appMenu.addItemWithTitle("Show All", action: "unhideAllApplications:", keyEquivalent: "")

		appMenu.addItem(NSMenuItem.separatorItem())
		appMenu.addItemWithTitle("Services", action: nil, keyEquivalent: "")!.submenu	=	appServicesMenu
		appMenu.addItem(NSMenuItem.separatorItem())
		appMenu.addItemWithTitle("Quit Me", action: "terminate:", keyEquivalent: "q")

		let	fileMenu		=	NSMenu(title: "File")
		mainFileMenuItem.submenu	=	fileMenu
		fileMenu.addItemWithTitle("New...", action: "newDocument:", keyEquivalent: "n")

		NSApplication.sharedApplication().mainMenu		=	mainMenu
	}

}

autoreleasepool {
	let	del	=	AppDelegate()
	NSApplication.sharedApplication().delegate	=	del
	NSApplication.sharedApplication().run()
}