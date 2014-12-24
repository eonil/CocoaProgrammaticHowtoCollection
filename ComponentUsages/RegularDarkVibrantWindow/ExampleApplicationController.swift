//
//  ExampleApplicationController.swift
//  RegularDarkVibrantWindow
//
//  Created by Hoon H. on 2014/12/25.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

import Cocoa



class ExampleApplicationController: NSObject, NSApplicationDelegate {
	
	let	window	=	NSWindow()
	func applicationDidFinishLaunching(aNotification: NSNotification) {
		
		let	c1				=	NSVisualEffectView()
		c1.material			=	NSVisualEffectMaterial.AppearanceBased
		c1.blendingMode		=	NSVisualEffectBlendingMode.BehindWindow
		c1.state			=	NSVisualEffectState.FollowsWindowActiveState
		c1.needsDisplay		=	true
		window.contentView	=	c1
		
		//
		//	Don't try to make `NSBorderlessWindowMask` or `NSFullSizeContentViewWindowMask` window style
		//	with round-cornered view in it.
		//	It will make bad (jagged) corner rendering.
		//	It is good for you mental health just to follow Apple's regular appearance policy.
		
//		window.backgroundColor	=	NSColor.clearColor()
//		window.opaque			=	false
//		window.styleMask		=	NSBorderlessWindowMask | NSResizableWindowMask | NSFullSizeContentViewWindowMask
//		window.styleMask		=	NSResizableWindowMask | NSHUDWindowMask | NSMiniaturizableWindowMask | NSClosableWindowMask | NSTitledWindowMask | NSUtilityWindowMask
		window.styleMask		=	NSResizableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask | NSClosableWindowMask
		window.movableByWindowBackground	=	true
//		window.titlebarAppearsTransparent	=	true
		window.title			=	"Regular Dark Vibrant Window"
		window.appearance		=	NSAppearance(named: NSAppearanceNameVibrantDark)
		
		window.setFrame(CGRect(x: 100, y: 100, width: 800, height: 600), display: false)
		window.makeKeyAndOrderFront(self)
		window.invalidateShadow()
		
//		makeDark(window.standardWindowButton(NSWindowButton.CloseButton)!)
//		makeDark(window.standardWindowButton(NSWindowButton.MiniaturizeButton)!)
//		makeDark(window.standardWindowButton(NSWindowButton.ZoomButton)!)
	}
}

//private func makeDark(b:NSButton) {
//	//	CIFilter doesn't work on standard buttons. Don't know why.
////	let	f	=	CIFilter(name: "CIColorControls")
////	f.setValue(NSNumber(float: 1), forKey: "inputSaturation")
////	b.layerUsesCoreImageFilters	=	true
////	b.layer!.filters			=	[f]
//	b.alphaValue	=	0.5
//}







