//
//  ExampleTableViewController.swift
//  AutosizingTableTest1
//
//  Created by Hoon H. on 2015/11/26.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation
import UIKit

/// 1. Set `estimatedRowHeight`. Do not set anothing else.
/// 2. Take care that constraint not to break each other.
///
///
class ExampleTableViewController: UITableViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView!.registerClass(ExampleCell.self, forCellReuseIdentifier: "CELL")
		tableView!.estimatedRowHeight	=	100
	}
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		tableView!.reloadData()
	}
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return	1
	}
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return	100
	}
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let	cell	=	tableView.dequeueReusableCellWithIdentifier("CELL")! as! ExampleCell
		return	cell
	}
}

class ExampleCell: UITableViewCell {
	override func willMoveToWindow(newWindow: UIWindow?) {
		super.willMoveToWindow(newWindow)
		if _aa.superview === nil {
			_aa.translatesAutoresizingMaskIntoConstraints	=	false
			_aa.text		=	Array<String>(count: random() % 10, repeatedValue: "AAA").joinWithSeparator("\n")
			_aa.numberOfLines	=	0
			contentView.addSubview(_aa)
			contentView.addConstraints([
				contentView.topAnchor.constraintEqualToAnchor(_aa.topAnchor),
				contentView.bottomAnchor.constraintEqualToAnchor(_aa.bottomAnchor),
				contentView.leftAnchor.constraintEqualToAnchor(_aa.leftAnchor),
				contentView.rightAnchor.constraintGreaterThanOrEqualToAnchor(_aa.rightAnchor)
				])
		}
	}
//	override func didMoveToWindow() {
//		super.didMoveToWindow()
//		if window != nil {
//		}
//	}
	private let _aa		=	UILabel()
}








