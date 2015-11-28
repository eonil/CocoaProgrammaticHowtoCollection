//
//  Cell1.swift
//  UICollectionViewCustomLayout
//
//  Created by Hoon H. on 2015/11/28.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation
import UIKit

protocol Cell1Delegate: class {
	func Cell1DidChangeSize()
}

class Cell1: UICollectionViewCell, UITextViewDelegate {
	static func reuseIdentifier() -> String {
		return	NSStringFromClass(self)
	}

	weak var delegate: Cell1Delegate?

	///

	override func willMoveToWindow(newWindow: UIWindow?) {
		super.willMoveToWindow(newWindow)
		if newWindow != nil {
			_reconfigure()
			setNeedsLayout()
		}
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		_textView1.frame	=	contentView.bounds
	}
	override func sizeThatFits(size: CGSize) -> CGSize {
		let	sz		=	_textView1.sizeThatFits(size)
		return	sz
	}

	@objc
	func textViewDidChange(textView: UITextView) {
		_textView1.scrollEnabled	=	false
		print(_textView1.sizeThatFits(contentView.bounds.size))
		delegate?.Cell1DidChangeSize()
	}



	///

	private let	_textView1	=	UITextView()

	private func _reconfigure() {
		_textView1.textAlignment	=	NSTextAlignment.Center
		_textView1.font			=	UIFont.systemFontOfSize(10)
		_textView1.textColor		=	UIColor.redColor()
		_textView1.delegate		=	self
		contentView.addSubview(_textView1)
	}
}











