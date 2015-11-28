//
//  Extensions1.swift
//  UICollectionViewCustomLayout
//
//  Created by Hoon H. on 2015/11/28.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation
import UIKit

extension CGSize {
	func max(size: CGSize) -> CGSize {
		return	CGSize(width: Swift.max(width, size.width), height: Swift.max(height, size.height))
	}
}
struct Matrix2D {
	static func translation(p: CGPoint) -> CGAffineTransform {
		return	CGAffineTransformMakeTranslation(p.x, p.y)
	}
	static func rotation(a: Radians) -> CGAffineTransform {
		return	CGAffineTransformMakeRotation(a.value)
	}
}
func *(a: CGAffineTransform, b: CGAffineTransform) -> CGAffineTransform {
	return	CGAffineTransformConcat(a, b)
}

extension CGRect {
	var midPoint: CGPoint {
		get {
			return	CGPoint(x: midX, y: midY)
		}
	}
}

struct Radians {
	init(_ value: CGFloat) {
		self.value	=	value
	}
	init(_ value: Int) {
		self.value	=	CGFloat(value)
	}
	init(degrees: CGFloat) {
		self.value	=	CGFloat(M_PI / 180 * Double(degrees))
	}
	let value: CGFloat
}
func *(a: Radians, b: Radians) -> Radians {
	return	Radians(a.value * b.value)
}




