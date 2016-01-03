//
//  AppDelegate.swift
//  NSTextViewWithCustomInactiveSelectionBackgroundColor
//
//  Created by Hoon H. on 2016/01/03.
//  Copyright © 2016 Eonil. All rights reserved.
//

import Cocoa

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Here's the core.
//
// Read the manual carefully.
// 
// > ... the charRange and color parameters are passed in merely for informational purposes; the color is
// > already set in the graphics state. If for any reason you modify it, you must restore it before 
// > returning from this method. ...
// 
// Which means passing-in other color into `super` call has no effect, and you just need to
// `NSColor.setFill` to make it work with `super` call.
// Also, the manual requires to set it back to original one.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
final class LayoutManager1: NSLayoutManager {
	override func fillBackgroundRectArray(rectArray: UnsafePointer<NSRect>, count rectCount: Int, forCharacterRange charRange: NSRange, color: NSColor) {
		let color1 = color == NSColor.secondarySelectedControlColor() ? NSColor.redColor() : color
		color1.setFill()
		super.fillBackgroundRectArray(rectArray, count: rectCount, forCharacterRange: charRange, color: color1)
		color.setFill()
	}
}

final class AppDelegate: NSObject, NSApplicationDelegate {
	let mainWindow = NSWindow(
		contentRect: CGRect(x: 100, y: 100, width: 400, height: 400),
		styleMask: NSResizableWindowMask | NSTitledWindowMask,
		backing: NSBackingStoreType.Buffered,
		`defer`: false)
	let layoutManager1 = LayoutManager1()
	func applicationDidFinishLaunching(aNotification: NSNotification) {
		let scrollView = NSScrollView()
		scrollView.hasVerticalScroller = true
		scrollView.hasHorizontalScroller = true
		let textView = NSTextView()
		textView.frame = CGRect(x: 0, y: 0, width: 300, height: 1000)
		textView.textContainer!.replaceLayoutManager(layoutManager1)
		textView.string = "ABCD"
		textView.verticallyResizable = true
		scrollView.documentView = textView
		mainWindow.contentView = scrollView
		mainWindow.makeKeyAndOrderFront(self)
		mainWindow.makeFirstResponder(textView)
	}
}

autoreleasepool {
	let app = NSApplication.sharedApplication()
	let appDelegate = AppDelegate()
	app.delegate = appDelegate
	app.run()
}





