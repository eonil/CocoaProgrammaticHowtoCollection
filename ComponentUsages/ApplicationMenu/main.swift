//
//  main.swift
//  ApplicationMenu
//
//  Created by Hoon H. on 2015/11/07.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Cocoa


class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let    mainMenu             =    NSMenu() //< `title` really doesn't matter here.
        let    mainAppMenuItem      =    NSMenuItem(title: "Application", action: nil, keyEquivalent: "") //< `title` really doesn't matter here.
        let    mainFileMenuItem     =    NSMenuItem(title: "File", action: nil, keyEquivalent: "")
        mainMenu.addItem(mainAppMenuItem)
        mainMenu.addItem(mainFileMenuItem)

        let    appMenu              =    NSMenu() //< `title` really doesn't matter here.
        mainAppMenuItem.submenu     =    appMenu

        let    appServicesMenu      =    NSMenu()
        NSApp.servicesMenu          =    appServicesMenu
        appMenu.addItem(withTitle: "About Me", action: nil, keyEquivalent: "")
        appMenu.addItem(NSMenuItem.separator())
        appMenu.addItem(withTitle: "Preferences...", action: nil, keyEquivalent: ",")
        appMenu.addItem(NSMenuItem.separator())
        appMenu.addItem(withTitle: "Hide Me", action: #selector(NSApplication.hide(_:)), keyEquivalent: "h")
        appMenu.addItem({ ()->NSMenuItem in
            let m = NSMenuItem(title: "Hide Others", action: #selector(NSApplication.hideOtherApplications(_:)), keyEquivalent: "h")
            m.keyEquivalentModifierMask = NSEventModifierFlags([.command, .option])
            return m
            }())
        appMenu.addItem(withTitle: "Show All", action: #selector(NSApplication.unhideAllApplications(_:)), keyEquivalent: "")

        appMenu.addItem(NSMenuItem.separator())
        appMenu.addItem(withTitle: "Services", action: nil, keyEquivalent: "").submenu    =    appServicesMenu
        appMenu.addItem(NSMenuItem.separator())
        appMenu.addItem(withTitle: "Quit Me", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")

        let    fileMenu             =    NSMenu(title: "File")
        mainFileMenuItem.submenu    =    fileMenu
        fileMenu.addItem(withTitle: "New...", action: #selector(NSDocumentController.newDocument(_:)), keyEquivalent: "n")

        NSApplication.shared().mainMenu = mainMenu
    }

}

autoreleasepool {
    let del = AppDelegate()
    NSApplication.shared().delegate = del
    NSApplication.shared().run()
}
