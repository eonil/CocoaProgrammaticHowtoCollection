//
//  ExampleApplicationController.swift
//  SplitViewExample
//
//  Created by Hoon H. on 10/12/14.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

import Cocoa



class ExampleApplicationController: NSObject, NSApplicationDelegate {
	class ExampleController {
		
		let	window1	=	NSWindow()
		let	scroll1	=	NSScrollView()
		let	text1	=	NSTextView()
		
		init(wordwrap:Bool){
			window1.title			=	"WordWrap = \(wordwrap)"
			window1.styleMask		|=	NSResizableWindowMask | NSClosableWindowMask | NSResizableWindowMask | NSMiniaturizableWindowMask
			window1.setFrame(CGRect(x: wordwrap ? 400 : 0, y: 0, width: 400, height: 500), display: true)
//			window1.setFrameOrigin(NSScreen.mainScreen()!.frame.)
			window1.makeKeyAndOrderFront(self)
			window1.contentView		=	scroll1
			
			scroll1.hasVerticalScroller		=	true
			scroll1.hasHorizontalScroller	=	true
			scroll1.documentView			=	text1
			
			scroll1.autoresizingMask		=	NSAutoresizingMaskOptions.ViewWidthSizable | NSAutoresizingMaskOptions.ViewHeightSizable
			text1.autoresizingMask			=	NSAutoresizingMaskOptions.ViewWidthSizable | NSAutoresizingMaskOptions.ViewHeightSizable
			
			////
			
			text1.minSize	=	CGSize(width: 0, height: 0)
			text1.maxSize	=	CGSize(width: CGFloat.max, height: CGFloat.max)
			
			text1.verticallyResizable					=	true
			text1.horizontallyResizable					=	true
			
			if wordwrap {
				///	Matching width is also important here.
				let	sz1										=	scroll1.contentSize
				text1.frame									=	CGRect(x: 0, y: 0, width: sz1.width, height: 0)
				text1.textContainer!.containerSize			=	CGSize(width: sz1.width, height: CGFloat.max)
				text1.textContainer!.widthTracksTextView	=	true
			} else {
//				text1.frame									=	CGRect(x: 0, y: 0, width: 0, height: 0)
				text1.textContainer!.widthTracksTextView	=	false
				text1.textContainer!.containerSize			=	CGSize(width: CGFloat.max, height: CGFloat.max)
			}
			
			text1.string				=	Resources.exampleText
		}
	}
	
	let	example1	=	ExampleController(wordwrap: false)
	let	example2	=	ExampleController(wordwrap: true)
}






struct Resources {
	static let		exampleText	=	"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n"
}





