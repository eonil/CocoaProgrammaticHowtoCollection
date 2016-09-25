//
//  main.swift
//  RegularDarkVibrantWindow
//
//  Created by Hoon H. on 10/12/14.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

import AppKit

let app1 = NSApplication.shared() //< You need to retain the application object in stack. Otherwise it will be killed immediately.
let con1 = ExampleApplicationController() //< So do this too...

app1.delegate = con1
app1.run()
