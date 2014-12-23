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
		let	view1	=	NSView()
		
		init(){
			view1.wantsLayer				=	true
			view1.layer!.cornerRadius		=	10
			view1.layer!.backgroundColor	=	NSColor.whiteColor().CGColor
			
			//
			//	The `view1` must be configured BEFORE added to `window1`.
			//	Otherwise, the window shadow will not work properly. Seems to be a bug in the SDK.
			//
			
			window1.setFrame(CGRect(x: 400, y: 0, width: 400, height: 500), display: true)
			window1.contentView					=	view1
			
			window1.backgroundColor				=	NSColor.clearColor()
			window1.opaque						=	false
			window1.styleMask					=	NSBorderlessWindowMask | NSResizableWindowMask
			window1.movableByWindowBackground	=	true
			window1.makeKeyAndOrderFront(self)
			
		}
	}
	
	let	example1	=	ExampleController()
}







