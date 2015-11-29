//
//  Input1.swift
//  ConversationUIExample
//
//  Created by Hoon H. on 2015/11/28.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation
import UIKit

class Input1: UIView, UITextViewDelegate {
	override init(frame: CGRect) {
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
		_reconfigure()
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		fatalError()
	}
	override func willMoveToWindow(newWindow: UIWindow?) {
		super.willMoveToWindow(newWindow)
		if newWindow != nil {
			_render()
		}
	}
	override func didMoveToWindow() {
		super.didMoveToWindow()
		if window != nil {
			_render()
		}
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		_render()
	}
	override func intrinsicContentSize() -> CGSize {
		let	sz	=	_textView.sizeThatFits(CGSize(width: bounds.width, height: CGFloat.max))
		let	sz1	=	CGSize(width: bounds.width, height: min(_MAX_HEIGHT, sz.height))
		return	sz1
	}



	// MARK: -
	func textViewDidChange(textView: UITextView) {
		// UITextView will scroll up undesirably because
		// there's no space for new line character. And resize
		// will be done later, and finally, you'll see scrolling up
		// and an empty space at the bottom of the view.
		// To prevent it, increase size of text view BEFORE performing
		// layout. This will prevent undesired scrolling and empty space.
		if _textView.frame.height < _MAX_HEIGHT {
			_textView.sizeToFit()
		}
		invalidateIntrinsicContentSize()
	}


	
	// MARK: -
	private let _textView		=	UITextView()
	private func _reconfigure() {
		autoresizingMask		=	.FlexibleHeight
		_textView.backgroundColor	=	UIColor.greenColor()
		_textView.font			=	UIFont.systemFontOfSize(13)
		_textView.delegate		=	self
		addSubview(_textView)
	}
	private func _render() {
		_textView.frame			=	bounds
	}
}

private let	_MAX_HEIGHT	=	CGFloat(100)










