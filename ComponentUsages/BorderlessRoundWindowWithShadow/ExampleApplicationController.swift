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
			window1.setFrame(CGRect(x: 400, y: 0, width: 400, height: 500), display: true)
			window1.contentView					=	view1
			
			window1.backgroundColor				=	NSColor.clearColor()
			window1.opaque						=	false
			window1.styleMask					=	NSBorderlessWindowMask | NSResizableWindowMask
			window1.movableByWindowBackground	=	true
			window1.makeKeyAndOrderFront(self)
			
			view1.wantsLayer				=	true
			view1.layer!.cornerRadius		=	10
			view1.layer!.backgroundColor	=	NSColor.whiteColor().CGColor
			
			///	:ref:	http://stackoverflow.com/questions/19940019/nswindow-with-round-corners-and-shadow/27613308#21247949
			window1.invalidateShadow()	//	This manual invalidation is REQUIRED because shadow generation is an expensive operation.
		}
	}
	
	let	example1	=	ExampleController()
}







