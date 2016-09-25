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
// Note
// ----
// `NSTextInputClient` need to be implemented by a `NSView`. 
// Having separated dedicated object for delegation doesn't work. (I don't know how to make it work)
//
// This also fully support IME. Try input Korean text.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////

final class ExampleView: NSView, NSTextInputClient {
    var _buffer = NSMutableString()
    var _markedRange = nil as CountableRange<UTF16Index>?
    
    // Essential methods.
    // You need to make some proper selection management for your application.

    func selectedRange() -> NSRange {
        return NSRange(location: _buffer.length, length: 0)
    }
    func markedRange() -> NSRange {
        return NSRange.fromUTF16Range(_markedRange)
    }
    func hasMarkedText() -> Bool {
        return _markedRange != nil
    }
    
    func insertText(_ aString: Any, replacementRange: NSRange) {
        let s = findNSStringObject(aString as AnyObject)
        let r = replacementRange.location != NSNotFound ? replacementRange : (_markedRange != nil ? self.markedRange() : self.selectedRange())
        
        _buffer.replaceCharacters(in: r, with: s as String)
        self.unmarkText()
        self.inputContext!.invalidateCharacterCoordinates()
        
        Swift.print("insertText, current buffer = \(_buffer)")
    }
    func setMarkedText(_ aString: Any, selectedRange: NSRange, replacementRange: NSRange) {
        let s = findNSStringObject(aString as AnyObject)
        let r = replacementRange.location != NSNotFound ? replacementRange : (_markedRange != nil ? self.markedRange() : self.selectedRange())
        
        _buffer.replaceCharacters(in: r, with: s as String)
        _markedRange = r.location..<(r.location+s.length)
            
        Swift.print("setMarkedText, current buffer = \(_buffer)")
    }
    func unmarkText() {
        _markedRange = nil
        self.inputContext!.discardMarkedText()
        
        Swift.print("unmarkText, current buffer = \(_buffer)")
    }
    
    
    
    /// Non-essential methods, but required.
    func attributedSubstring(forProposedRange aRange: NSRange, actualRange: NSRangePointer?) -> NSAttributedString? {
        return nil
    }
    func validAttributesForMarkedText() -> [String] {
        return []
    }
    func firstRect(forCharacterRange aRange: NSRange, actualRange: NSRangePointer?) -> NSRect {
        return CGRect.zero
    }
    func characterIndex(for aPoint: NSPoint) -> Int {
        return NSNotFound
    }

    
    
    // Boilerplates, and required.
    // If you don't override these methods, the view will not accept any keyboard input.
    override var acceptsFirstResponder:Bool {
        get {
            return true
        }
    }
    override func becomeFirstResponder() -> Bool {
        return true
    }
    override func resignFirstResponder() -> Bool {
        return true
    }
    override func keyDown(with theEvent: NSEvent) {
        self.inputContext!.handleEvent(theEvent)
    }
}






































/// MARK:
/// MARK:    Boilerplates

typealias    UTF16Index    =    Int

extension NSRange {
    static func fromUTF16Range(_ range:CountableRange<UTF16Index>?) -> NSRange {
        if let r = range {
            return    NSRange(location: r.lowerBound, length: r.upperBound - r.lowerBound)
        }
        return    NSRange(location: NSNotFound, length: 0)
    }
}

func findNSStringObject(_ o:AnyObject) -> NSString {
    if o is NSString {
        return    o as! NSString
    }
    if o is NSAttributedString {
        return    (o as! NSAttributedString).string as NSString
    }
    fatalError()
}




final class BoilerplateApplicationController: NSObject, NSApplicationDelegate {
    let    window1    =    NSWindow()
    let    view1    =    ExampleView()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window1.setFrame(CGRect(x: 0, y: 0, width: 800, height: 500), display: true)
        window1.makeKeyAndOrderFront(self)
        window1.contentView    =    view1
    }
}


let    app1        =    NSApplication.shared()
let    con1        =    BoilerplateApplicationController()

app1.delegate    =    con1
app1.run()







