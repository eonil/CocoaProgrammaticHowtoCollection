//
//  main.swift
//  CollectionView
//
//  Created by Hoon H. on 2015/01/18.
//  Copyright (c) 2015 Eonil. All rights reserved.
//

import AppKit

final class ExampleApplicationController: NSObject, NSApplicationDelegate {

    /// Seems fine to create AppKit UI classes before `NSApplication` object
    /// to be created starting OSX 10.10. (it was an error in OSX 10.9)
    let window1 = NSWindow()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window1.setFrame(CGRect(x: 0, y: 0, width: 800, height: 500), display: true)
        window1.makeKeyAndOrderFront(self)

        ////

        let sv = NSScrollView()
        let cv = NSCollectionView()

        window1.contentView =   sv
        sv.documentView     =   cv
        cv.itemPrototype    =   ExampleItemViewController()
        cv.content          =   ["AAA", "BBB", "CCC"]
    }
}

final class ExampleItemViewController: NSCollectionViewItem {
    override func loadView() {
        super.view = NSTextField()
    }

    override var representedObject: Any? {
        get {
            return (self.view as! NSTextField).objectValue as AnyObject?
        }
        set {
            (self.view as! NSTextField).objectValue = newValue
        }
    }
}










let app1 = NSApplication.shared()
let con1 = ExampleApplicationController()

app1.delegate = con1
app1.run()
