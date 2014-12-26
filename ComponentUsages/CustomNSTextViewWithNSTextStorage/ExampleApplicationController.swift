//
//  ExampleApplicationController.swift
//  CustomNSTextViewWithNSTextStorage
//
//  Created by Hoon H. on 2014/12/26.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

import Cocoa







/////////////////////////////////////////////////////////////////////////////
//
//	Minimal example to customise `NSTextView` with custom `NSTextStorage`.
//
/////////////////////////////////////////////////////////////////////////////




class CustomTextView: NSTextView {
	//
	//	I don't know why, but this must be owned by `self`.
	//	Otherwise your app will be crashed.
	//	Seems to be related to ownership.
	//	Cited from documentation:
	//
	//	>	There are two standard ways to create an object web of the
	//	>	four principal classes of the text system to handle text 
	//	>	editing, layout, and display: in one case, the text view
	//	>	creates and owns the other objects; in the other case, you
	//	>	create all the objects explicitly and the text storage owns 
	//	>	them.
	//
	var	s:CustomTextStorage?
	
	override init() {
		super.init()
	}
	
	override init(frame frameRect: NSRect, textContainer container: NSTextContainer?) {
		super.init(frame: frameRect, textContainer: container)
		s	=	CustomTextStorage()
		layoutManager!.replaceTextStorage(s!)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		s	=	CustomTextStorage()
		layoutManager!.replaceTextStorage(s!)
	}
}




class CustomTextStorage: NSTextStorage {
	var	s	=	""
	
	override var string:String {
		get {
			return	s
		}
	}
	
	override func attributesAtIndex(location: Int, effectiveRange range: NSRangePointer) -> [NSObject : AnyObject] {
		
		//
		//	`range` is an output parameter! You must set it to a proper value.
		//
		if range != nil {
			range.memory	=	NSRange(location: 0, length: self.length)
		}
		
		return	[NSFontAttributeName: NSFont.systemFontOfSize(24)]
	}
	
	override func replaceCharactersInRange(range: NSRange, withString str: String) {
		s	=	(s as NSString).stringByReplacingCharactersInRange(range, withString: str)
		
		let	d	=	range.length - (str as NSString).length
		let	d1	=	abs(d)
		
		//
		//	Changes must be notified!
		//
		self.edited(Int(NSTextStorageEditedOptions.Characters.rawValue), range: range, changeInLength: d1)
	}
	override func setAttributes(attrs: [NSObject : AnyObject]?, range: NSRange) {
		
		//
		//	Changes must be notified!
		//
		self.edited(Int(NSTextStorageEditedOptions.Attributes.rawValue), range: range, changeInLength: 0)
	}
}















class ExampleApplicationController: NSObject, NSApplicationDelegate {
	let	window1	=	NSWindow()
	
	func applicationDidFinishLaunching(aNotification: NSNotification) {
		window1.styleMask		|=	NSResizableWindowMask | NSClosableWindowMask | NSResizableWindowMask | NSMiniaturizableWindowMask
		window1.setFrame(CGRect(x: 400, y: 400, width: 400, height: 500), display: true)
		window1.makeKeyAndOrderFront(self)
		
		////
		
		let	s	=	NSScrollView()
		let	t	=	CustomTextView()
		
		t.string				=	"ABC"
		t.verticallyResizable	=	true
		t.horizontallyResizable	=	true
		
		s.documentView			=	t
		s.hasVerticalScroller	=	true
		s.hasHorizontalScroller	=	true
		window1.contentView		=	s
	}
}











