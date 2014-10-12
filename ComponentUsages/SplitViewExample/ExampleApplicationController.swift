//
//  ExampleApplicationController.swift
//  SplitViewExample
//
//  Created by Hoon H. on 10/12/14.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

import Cocoa

class ExampleApplicationController: NSObject, NSApplicationDelegate {

	///	Seems fine to create AppKit UI classes before `NSApplication` object
	///	to be created starting OSX 10.10. (it was an error in OSX 10.9)
	
	let	window1	=	NSWindow()
	let	split1	=	NSSplitViewController()

	func applicationDidFinishLaunching(aNotification: NSNotification) {
		window1.styleMask		|=	NSResizableWindowMask
		window1.setFrame(CGRect(x: 0, y: 0, width: 800, height: 500), display: true)
		window1.makeKeyAndOrderFront(self)
		window1.contentView	=	split1.view
		
		////
		
		///	Do not set frame explicitly. It will make the view unresizable.
//		split1.view.frame		=	CGRect(x: 0, y: 0, width: 200, height: 200)
		
		func make1() -> NSViewController {
			let	vc1		=	NSViewController()
			vc1.view	=	NSView()
//			vc1.view.translatesAutoresizingMaskIntoConstraints	=	false
			vc1.view.wantsLayer	=	true
			vc1.view.layer!.backgroundColor	=	NSColor.blueColor().CGColor
			return	vc1
		}
		func setup1(vc1:NSViewController) {
			///	Layout constraints must be installed after the view is added to a view hierarchy.
			split1.view.addConstraint(NSLayoutConstraint(item: vc1.view, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 0, constant: 20))
			split1.view.addConstraint(NSLayoutConstraint(item: vc1.view, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.LessThanOrEqual, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 0, constant: 300))
		}
		
		split1.addSplitViewItem(NSSplitViewItem(viewController: make1()))
		split1.addSplitViewItem(NSSplitViewItem(viewController: make1()))
		split1.addSplitViewItem(NSSplitViewItem(viewController: make1()))
		
		setup1(split1.splitViewItems[0].viewController)
		setup1(split1.splitViewItems[1].viewController)
		setup1(split1.splitViewItems[2].viewController)
	}

	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}
	
}

