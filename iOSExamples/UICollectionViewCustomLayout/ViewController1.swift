//
//  ViewController1.swift
//  UICollectionViewCustomLayout
//
//  Created by Hoon H. on 2015/11/28.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation
import UIKit

class ViewController1: UICollectionViewController, Cell1Delegate {
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView!.registerClass(Cell1.self, forCellWithReuseIdentifier: Cell1.reuseIdentifier())
	}

	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return	1
	}
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return	_NUM_CELLS
	}
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let	cell	=	collectionView.dequeueReusableCellWithReuseIdentifier(Cell1.reuseIdentifier(), forIndexPath: indexPath) as! Cell1
		cell.delegate	=	self
		return	cell
	}

	func Cell1DidChangeSize() {
		UIView.animateWithDuration(1) { [weak self] in
			self?.collectionView!.collectionViewLayout.invalidateLayout()
		}
	}
}

private let	_NUM_CELLS	=	16