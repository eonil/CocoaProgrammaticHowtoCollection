//
//  Extensions1.swift
//  ConversationUIExample
//
//  Created by Hoon H. on 2015/11/28.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
	func rectByResettingWidth(value: CGFloat) -> CGRect {
		var	f1	=	self
		f1.size.width	=	value
		return	f1
	}
	func rectByResettingHeight(value: CGFloat) -> CGRect {
		var	f1	=	self
		f1.size.height	=	value
		return	f1
	}
	var midBottom: CGPoint {
		get {
			return	CGPoint(x: midX, y: maxY)
		}
	}
	var leftBottom: CGPoint {
		get {
			return	CGPoint(x: minX, y: maxY)
		}
	}
}
extension CGSize {
	func max(size: CGSize) -> CGSize {
		return	CGSize(width: Swift.max(width, size.width), height: Swift.max(height, size.height))
	}
}
func -(a: CGSize, b: CGSize) -> CGSize {
	return	CGSize(width: a.width - b.width, height: a.height - b.height)
}
extension UIScrollView {
	var scrollableSize: CGSize {
		get {
			return	(contentSize - bounds.size).max(CGSize.zero)
		}
	}
}










