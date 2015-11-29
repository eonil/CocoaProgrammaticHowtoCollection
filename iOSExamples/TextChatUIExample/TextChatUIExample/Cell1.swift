//
//  Cell1.swift
//  ConversationUIExample
//
//  Created by Hoon H. on 2015/11/28.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation
import UIKit

class Cell1: UICollectionViewCell {
	// MARK: -
	static func reuseIdentifier() -> String {
		return	NSStringFromClass(self)
	}

	weak var segment: Segment1? {
		didSet {
			_render()
		}
	}

	// MARK: -
	override func didMoveToWindow() {
		super.didMoveToWindow()
		if window != nil {
			_reconfigure()
		}
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		_render()
	}
	override func sizeThatFits(size: CGSize) -> CGSize {
		return	_textView.sizeThatFits(size)
	}
//	override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//		let	att	=	super.preferredLayoutAttributesFittingAttributes(layoutAttributes)
//		att.size	=	sizeThatFits(CGSize.zero)
//		return	att
//	}

	// MARK: -
	private let	_textView	=	_TextView()
	private func _reconfigure() {
		backgroundColor	=	UIColor.whiteColor()
		_textView.scrollEnabled	=	false
		_textView.editable	=	false
		contentView.addSubview(_textView)
	}
	private func _render() {
		_textView.frame		=	contentView.bounds
		_textView.text		=	segment?.getText()
	}
}

private class _TextView: UITextView {
	private override func canBecomeFirstResponder() -> Bool {
		return	false
	}
}





