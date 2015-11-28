//
//  Layout1.swift
//  UICollectionViewCustomLayout
//
//  Created by Hoon H. on 2015/11/28.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation
import UIKit

class Layout1: UICollectionViewLayout {

	// MARK: -
	override func collectionViewContentSize() -> CGSize {
		return	collectionView!.bounds.size
	}
	override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		var atts	=	[UICollectionViewLayoutAttributes]()
		for section in 0..<(collectionView!.dataSource!.numberOfSectionsInCollectionView!(collectionView!)) {
			for item in 0..<collectionView!.dataSource!.collectionView(collectionView!, numberOfItemsInSection: section) {
				let	att	=	layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: item, inSection: section))!
				atts.append(att)
			}
		}
		return	atts
	}
	override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
		let	ratio	=	CGFloat(indexPath.item) / CGFloat(_itemCountInSection(indexPath.section))
		let	att	=	UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
		let	defSZ	=	CGSize(width: 30, height: 60)
		att.size	=	collectionView!.cellForItemAtIndexPath(indexPath)?.sizeThatFits(CGSize.zero).max(defSZ) ?? defSZ
		att.center	=	collectionView!.bounds.midPoint
		att.zIndex	=	-indexPath.item
		att.alpha	=	1 - ratio
		att.transform	=	{
			let	y	=	120
			let	angle	=	CGFloat(2 * M_PI) * ratio
			let	a	=	Matrix2D.translation(CGPoint(x: 0, y: y))
			let	b	=	Matrix2D.rotation(Radians(angle))
			return	a * b
		}()
		return	att
	}
	override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
		return	true
	}
	override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
		return	layoutAttributesForItemAtIndexPath(itemIndexPath)
	}
	override func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
		return	layoutAttributesForItemAtIndexPath(itemIndexPath)
	}



	// MARK: -
	private func _itemCountInSection(section: Int) -> Int {
		return	collectionView!.dataSource!.collectionView(collectionView!, numberOfItemsInSection: section)
	}
}




































