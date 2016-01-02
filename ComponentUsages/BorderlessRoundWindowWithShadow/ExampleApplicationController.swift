//
//  ExampleApplicationController.swift
//  SplitViewExample
//
//  Created by Hoon H. on 10/12/14.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

import Cocoa



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// New approach. Precise round corner. Also masks content view properly.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ExampleApplicationController: NSObject, NSApplicationDelegate {
	class ExampleController {
		let	window1	=	NSWindow()
		init(){
			window1.backgroundColor				=	NSColor.whiteColor()
			window1.opaque						=	false
			window1.styleMask					=	NSResizableWindowMask
												|	NSTitledWindowMask
												|	NSFullSizeContentViewWindowMask
			window1.movableByWindowBackground	=	true
			window1.titlebarAppearsTransparent	=	true
			window1.titleVisibility				=	.Hidden
			window1.showsToolbarButton			=	false
			window1.standardWindowButton(NSWindowButton.FullScreenButton)?.hidden	=	true
			window1.standardWindowButton(NSWindowButton.MiniaturizeButton)?.hidden	=	true
			window1.standardWindowButton(NSWindowButton.CloseButton)?.hidden		=	true
			window1.standardWindowButton(NSWindowButton.ZoomButton)?.hidden			=	true

			window1.setFrame(CGRect(x: 400, y: 0, width: 400, height: 500), display: true)
			window1.makeKeyAndOrderFront(self)
		}
	}
	let	example1	=	ExampleController()
}






////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Old approach. Impossible to provide precise round corner.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//class ExampleApplicationController: NSObject, NSApplicationDelegate {
//	class ExampleController {
//		
//		let	window1	=	NSWindow()
//		let	view1	=	NSView()
//
//		init(){
//			window1.setFrame(CGRect(x: 400, y: 0, width: 400, height: 500), display: true)
//			window1.contentView					=	view1
//
//			window1.backgroundColor				=	NSColor.clearColor()
//			window1.opaque						=	false
//			window1.styleMask					=	NSBorderlessWindowMask | NSResizableWindowMask
//			window1.movableByWindowBackground	=	true
//			window1.makeKeyAndOrderFront(self)
//			
//			view1.wantsLayer				=	true
//			view1.layer!.cornerRadius		=	5
//			view1.layer!.backgroundColor	=	NSColor.whiteColor().CGColor
//		}
//	}
//	
//	let	example1	=	ExampleController()
//}







