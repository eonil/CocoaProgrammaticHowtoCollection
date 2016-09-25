//
//  main.swift
//  NSTableViewExample
//
//  Created by Hoon H. on 10/12/14.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

import AppKit

@objc
final class ExampleTableViewController : NSObject, NSTableViewDataSource, NSTableViewDelegate {

    let scroll = NSScrollView()
    let table = NSTableView()

    override init() {
        super.init()

        scroll.documentView = table
        scroll.hasVerticalScroller = true

        let tc1 = NSTableColumn(identifier: "NAME_COLUMN")
        tc1.title = "Name"
        table.addTableColumn(tc1)
        table.delegate = self
        table.dataSource = self
        table.rowSizeStyle = NSTableViewRowSizeStyle.small
    }

    @objc
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 1000
    }

    @objc
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let VIEW_ID1 = "VIEW_ID1"
        if let v1 = tableView.make(withIdentifier: VIEW_ID1, owner: nil) {
            print("Reused \(ObjectIdentifier(v1))")
            return v1
        } else {
            let v1 = NSTextField() //< Don't forget that you also can use `NSTableCellView` class for view-based tables.
            v1.identifier = VIEW_ID1 //< This is essential!
            return v1
        }
    }
    //    @objc
    //    func tableView(tableView: NSTableView, didAddRowView rowView: NSTableRowView, forRow row: Int) {
    //        rowViewPool.remove(ObjectBox(object: rowView))
    //    }
    //    @objc
    //    func tableView(tableView: NSTableView, didRemoveRowView rowView: NSTableRowView, forRow row: Int) {
    //        rowViewPool.insert(ObjectBox(object: rowView))
    //    }
}













///    MARK:
final class ApplicationController: NSObject, NSApplicationDelegate {
    let controller1 = ExampleTableViewController()
    let window1 = NSWindow()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window1.contentView = controller1.scroll
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

