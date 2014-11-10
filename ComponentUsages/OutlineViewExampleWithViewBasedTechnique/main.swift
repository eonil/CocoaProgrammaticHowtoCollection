//
//  main.swift
//  Bootstrapping
//
//  Created by Hoon H. on 10/12/14.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

import AppKit


///
///	ISSUE:	Currently tree nodes are placed slightly above than normal.
///	It seems due to lack of proper auto-layout constrains.
///	This layout glitch does not appear in other applications with many constraints.
///	So I don't fix this.
///


///
///	View-based table/outline view is far better and way to go. 
///	Always use view-based approach.
///
///	Reference:
///	http://stackoverflow.com/questions/19464136/view-based-nsoutlineview-without-nib/26325724#26325724
///
final class ExampleOutlineViewController : NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {
	
	let	outlineView	=	NSOutlineView()
	let	dataRoot	=	ExampleDataNode()
	
	var scrollView:NSScrollView {
		get {
			return	super.view as NSScrollView
		}
	}
	
	override func loadView() {
		self.view	=	NSScrollView()
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		
		scrollView.documentView	=	outlineView
		
		
		let	tc1	=	NSTableColumn(identifier: "NAME_COLUMN")
		tc1.title	=	"Name"
		
		outlineView.addTableColumn(tc1)
		outlineView.outlineTableColumn	=	tc1
		
		///	Always use a proper row-size-style.
		///	If you set this to `Custom`, `NSTableCellView` will not layout
		///	its text/image subviews, and you need to do it manually youtself.
		///	That's annoying. 
		///	If you want to adjust row-height, use this delegate method.
		///
		///		func outlineView(outlineView: NSOutlineView, heightOfRowByItem item: AnyObject) -> CGFloat
		///
		///	Do not set `NSTableView.rowHeight`. It needs the `rowSizeStyle` 
		///	set to `Custom`, (seems implicitly setting to it) and you will
		///	get unexpected result.
		outlineView.rowSizeStyle	=	NSTableViewRowSizeStyle.Small
		
		outlineView.setDataSource(self)
		outlineView.setDelegate(self)
		
		outlineView.reloadData()
		outlineView.expandItem(dataRoot)
	}
	
	
///	MARK:
	func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int {
		if item == nil {
			return	1
		} else {
			let	n1	=	item as ExampleDataNode
			return	n1.subnodes.count
		}
	}
	func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject {
		if item == nil {
			return	dataRoot
		} else {
			let	n1	=	item as ExampleDataNode
			return	n1.subnodes[index]
		}
	}
	func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool {
		return	self.outlineView(outlineView, numberOfChildrenOfItem: item) > 0
	}
	func outlineView(outlineView: NSOutlineView, heightOfRowByItem item: AnyObject) -> CGFloat {
		return	16
	}
	func outlineView(outlineView: NSOutlineView, viewForTableColumn tableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
		let	n1	=	item as ExampleDataNode
		let	t1	=	NSTextField()
		let	m1	=	NSImageView()
		
		t1.bordered			=	false
		t1.drawsBackground	=	false
		t1.stringValue		=	n1.text
		m1.image			=	NSWorkspace.sharedWorkspace().iconForFile("/")
		
		let	cv1	=	NSTableCellView()
		cv1.textField		=	t1
		cv1.imageView		=	m1
		
		///
		///	The text-field and image-view MUST BE RETAINED by adding to its owner `NSTableCellView`.
		///	Because `textField` and `imageView` properties are weak, then they will not be retains,
		///	and finally will be deallocated immediately when returning from this function.
		///
		///	Also, view-based table-view WON'T WORK AT ALL unless you set `rowSizeStyle` to non-`Custom`
		///	value. See `viewDidLoad` method for details.
		///
		cv1.addSubview(t1)
		cv1.addSubview(m1)
		return	cv1
	}
	
	
	
///	MARK:
	///	You usually need data-node object because you need to retain the data
	///	objects yourself. `NSOutlineView` do not retain the any data object.
	class ExampleDataNode {
		struct Counter {
			static var	number	=	0
		}
		
		let	text	=	"(some text: \(++Counter.number))"
		lazy var subnodes:[ExampleDataNode]	=	{
			let	n1	=	random() % 10 + 3
			var	a1	=	[ExampleDataNode]()
			for i in 0..<n1 {
				a1	+=	[ExampleDataNode()]
			}
			return	a1
		}()
	}
}













///	MARK:
final class ApplicationController: NSObject, NSApplicationDelegate {
	let	window1	=	NSWindow()
	
	func applicationDidFinishLaunching(aNotification: NSNotification) {
		window1.contentViewController		=	ExampleOutlineViewController()
		
		window1.styleMask					=	NSResizableWindowMask | NSTitledWindowMask
		window1.setFrame(CGRect(x: 0, y: 0, width: 800, height: 500), display: false)
		
		window1.makeKeyAndOrderFront(self)
	}
}

autoreleasepool { () -> () in
	let	app1		=	NSApplication.sharedApplication()
	let	con1		=	ApplicationController()
	
	app1.delegate	=	con1
	app1.run()
}

