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
//    Minimal example to customise `NSTextView` with custom `NSTextStorage`.
//
/////////////////////////////////////////////////////////////////////////////



final class ExampleApplicationController: NSObject, NSApplicationDelegate {
    /// If you use non-default text-storage,
    /// the storage must be retained by something else
    /// because `NSTextView` does not retain it.
    /// As a consequence, your app likely to be crashed.
    ///
    /// Cited from manual:
    ///
    /// > There are two standard ways to create an object web of the
    /// > four principal classes of the text system to handle text
    /// > editing, layout, and display: in one case, the text view
    /// > creates and owns the other objects; in the other case, you
    /// > create all the objects explicitly and the text storage owns
    /// > them.
    ///
    let textStorage1 = CustomTextStorage()

    let window1 = NSWindow()
    let scrollView1 = NSScrollView()
    let textView1 = NSTextView()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        assert(textView1.layoutManager != nil)
        textView1.layoutManager?.replaceTextStorage(textStorage1)

        window1.styleMask = NSWindowStyleMask([.resizable, .closable, .miniaturizable])
        window1.setFrame(CGRect(x: 400, y: 400, width: 400, height: 500), display: true)
        window1.makeKeyAndOrderFront(self)
        window1.contentView = scrollView1
        scrollView1.documentView = textView1
        scrollView1.hasVerticalScroller = true
        scrollView1.hasHorizontalScroller = true
        textView1.string = "ABC"
        textView1.isVerticallyResizable = true
        textView1.isHorizontallyResizable = true
    }
}








final class CustomTextStorage: NSTextStorage {
    var s = ""
    override var string:String {
        return s
    }
    override func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> [String : Any] {
        //
        // `range` is an output parameter! You must set it to a proper value.
        //
        if range != nil {
            range?.pointee = NSRange(location: 0, length: self.length)
        }
        
        return [NSFontAttributeName: NSFont.systemFont(ofSize: 24)]
    }
    override func replaceCharacters(in range: NSRange, with str: String) {
        s = (s as NSString).replacingCharacters(in: range, with: str)
        //
        // Changes must be notified!
        //
        let d = (str as NSString).length - range.length
        self.edited(NSTextStorageEditActions.editedCharacters, range: range, changeInLength: d) //< `d` must be delta. Keep the sign.
    }
    override func setAttributes(_ attrs: [String : Any]?, range: NSRange) {
        //
        // Changes must be notified!
        //
        self.edited(NSTextStorageEditActions.editedAttributes, range: range, changeInLength: 0)
    }
}

























