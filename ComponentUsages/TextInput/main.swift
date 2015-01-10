//
//  main.swift
//  TextInput
//
//  Created by Hoon H. on 2015/01/10
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import Cocoa




/////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Note
//	----
//	`NSTextInputClient` need to be implemented by a `NSView`. 
//	Having separated dedicated object for delegation doesn't work. (I don't know how to make it work)
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////




final class ExampleView: NSView, NSTextInputClient {
	var	_buffer				=	NSMutableString()
	var	_markedRange		=	nil as Range<UTF16Index>?
	
	//	Essential methods.
	//	You need to make some proper selection management for your application.

	func selectedRange() -> NSRange {
		return	NSRange(location: _buffer.length, length: 0)
	}
	func markedRange() -> NSRange {
		return	NSRange.fromUTF16Range(_markedRange)
	}
	func hasMarkedText() -> Bool {
		return	_markedRange != nil
	}
	
	func insertText(aString: AnyObject, replacementRange: NSRange) {
		let	s	=	findNSStringObject(aString)
		let	r	=	replacementRange.location != NSNotFound ? replacementRange : (_markedRange != nil ? self.markedRange() : self.selectedRange())
		
		_buffer.replaceCharactersInRange(r, withString: s)
		self.unmarkText()
		self.inputContext!.invalidateCharacterCoordinates()
		
		println("insertText, current buffer = \(_buffer)")
	}
	func setMarkedText(aString: AnyObject, selectedRange: NSRange, replacementRange: NSRange) {
		let	s	=	findNSStringObject(aString)
		let	r	=	replacementRange.location != NSNotFound ? replacementRange : (_markedRange != nil ? self.markedRange() : self.selectedRange())
		
		_buffer.replaceCharactersInRange(r, withString: s)
		_markedRange	=	r.location..<(r.location+s.length)
			
		println("setMarkedText, current buffer = \(_buffer)")
	}
	func unmarkText() {
		_markedRange	=	nil
		self.inputContext!.discardMarkedText()
		
		println("unmarkText, current buffer = \(_buffer)")
	}
	
	
	
	///	Non-essential methods, but required.
	func attributedSubstringForProposedRange(aRange: NSRange, actualRange: NSRangePointer) -> NSAttributedString? {
		return	nil
	}
	func validAttributesForMarkedText() -> [AnyObject] {
		return	[]
	}
	func firstRectForCharacterRange(aRange: NSRange, actualRange: NSRangePointer) -> NSRect {
		return	CGRect.zeroRect
	}
	func characterIndexForPoint(aPoint: NSPoint) -> Int {
		return	NSNotFound
	}

	
	
	//	Boilerplates, and required.
	//	If you don't override these methods, the view will not accept any keyboard input.
	override var acceptsFirstResponder:Bool {
		get {
			return	true
		}
	}
	override func becomeFirstResponder() -> Bool {
		return	true
	}
	override func resignFirstResponder() -> Bool {
		return	true
	}
	override func keyDown(theEvent: NSEvent) {
		self.inputContext!.handleEvent(theEvent)
	}
}






































///	MARK:
///	MARK:	Boilerplates

typealias	UTF16Index	=	Int

extension NSRange {
	static func fromUTF16Range(range:Range<UTF16Index>?) -> NSRange {
		if let r = range {
			return	NSRange(location: r.startIndex, length: r.endIndex - r.startIndex)
		}
		return	NSRange(location: NSNotFound, length: 0)
	}
}

func findNSStringObject(o:AnyObject) -> NSString {
	if o is NSString {
		return	o as NSString
	}
	if o is NSAttributedString {
		return	(o as NSAttributedString).string
	}
	fatalError()
}




final class BoilerplateApplicationController: NSObject, NSApplicationDelegate {
	let	window1	=	NSWindow()
	let	view1	=	ExampleView()
	
	func applicationDidFinishLaunching(aNotification: NSNotification) {
		window1.setFrame(CGRect(x: 0, y: 0, width: 800, height: 500), display: true)
		window1.makeKeyAndOrderFront(self)
		window1.contentView	=	view1
	}
}


let	app1		=	NSApplication.sharedApplication()
let	con1		=	BoilerplateApplicationController()

app1.delegate	=	con1
app1.run()







