//
//  main.swift
//  OutlineViewExample
//
//  Created by Hoon H. on 10/12/14.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

import AppKit


///
/// ISSUE: Currently tree nodes are placed slightly above than normal.
/// It seems due to lack of proper auto-layout constrains.
/// This layout glitch does not appear in other applications with many constraints.
/// So I don't fix this.
///


///
/// View-based table/outline view is far better and way to go.
/// Always use view-based approach.
///
/// Reference:
/// http://stackoverflow.com/questions/19464136/view-based-nsoutlineview-without-nib/26325724#26325724
///
final class ExampleOutlineViewController: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {
    
    let outlineView = NSOutlineView()
    let dataRoot = ExampleDataNode()
    
    var scrollView:NSScrollView {
        get {
            return super.view as! NSScrollView
        }
    }
    
    override func loadView() {
        self.view = NSScrollView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.documentView = outlineView
        
        
        let tc1 = NSTableColumn(identifier: "NAME_COLUMN")
        tc1.title = "Name"
        
        outlineView.addTableColumn(tc1)
        outlineView.outlineTableColumn = tc1
        
        /// Always use a proper row-size-style.
        /// If you set this to `Custom`, `NSTableCellView` will not layout
        /// its text/image subviews, and you need to do it manually youtself.
        /// That's annoying.
        /// If you want to adjust row-height, use this delegate method.
        ///
        ///     func outlineView(outlineView: NSOutlineView, heightOfRowByItem item: AnyObject) -> CGFloat
        ///
        /// Do not set `NSTableView.rowHeight`. It needs the `rowSizeStyle`
        /// set to `Custom`, (seems implicitly setting to it) and you will
        /// get unexpected result.
        outlineView.rowSizeStyle = NSTableViewRowSizeStyle.small
        
        outlineView.dataSource = self
        outlineView.delegate = self
        
        outlineView.reloadData()
        outlineView.expandItem(dataRoot)
    }
    
    
///    MARK:
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
            return 1
        } else {
            let n1 = item as! ExampleDataNode
            return n1.subnodes.count
        }
    }
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil {
            return    dataRoot
        } else {
            let n1 = item as! ExampleDataNode
            return n1.subnodes[index]
        }
    }
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return self.outlineView(outlineView, numberOfChildrenOfItem: item) > 0
    }
    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        return 16
    }
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        let n1 = item as! ExampleDataNode
        let t1 = NSTextField()
        let m1 = NSImageView()
        
        t1.isBordered = false
        t1.drawsBackground = false
        t1.stringValue = n1.text
        m1.image = NSWorkspace.shared().icon(forFile: "/")
        
        let cv1 = NSTableCellView()
        cv1.textField = t1
        cv1.imageView = m1
        
        ///
        /// The text-field and image-view MUST BE RETAINED by adding to its owner `NSTableCellView`.
        /// Because `textField` and `imageView` properties are weak, then they will not be retains,
        /// and finally will be deallocated immediately when returning from this function.
        ///
        /// Also, view-based table-view family won't work at all unless you set `rowSizeStyle` to
        /// non-`Custom` value. See `viewDidLoad` method for details.
        ///
        cv1.addSubview(t1)
        cv1.addSubview(m1)
        return    cv1
    }
    
    
    
    /// MARK:
    /// You usually need data-node object because you need to retain the data
    /// objects yourself. `NSOutlineView` do not retain the any data object.
    class ExampleDataNode {
        struct Counter {
            static var number = 0
            static func getIncremented() -> Int {
                number += 1
                return number
            }
        }

        let text = "(some text: \(Counter.getIncremented()))"
        lazy var subnodes:[ExampleDataNode] = {
            let n1 = arc4random() % 10 + 3
            var a1 = [ExampleDataNode]()
            for i in 0..<n1 {
                a1 += [ExampleDataNode()]
            }
            return a1
        }()
    }
}













///    MARK:
final class ApplicationController: NSObject, NSApplicationDelegate {
    let window1 = NSWindow()
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window1.contentViewController = ExampleOutlineViewController()
        window1.styleMask = NSWindowStyleMask([.resizable, .titled])
        window1.setFrame(CGRect(x: 0, y: 0, width: 800, height: 500), display: false)
        window1.makeKeyAndOrderFront(self)
    }
}

autoreleasepool { () -> () in
    let app1 = NSApplication.shared()
    let con1 = ApplicationController()
    
    app1.delegate = con1
    app1.run()
}

