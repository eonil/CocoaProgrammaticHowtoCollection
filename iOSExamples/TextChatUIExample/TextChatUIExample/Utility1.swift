//
//  Utility1.swift
//  TextChatUIExample
//
//  Created by Hoon H. on 2015/11/29.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation

func callWithTemporaryTrueContext(inout state: Bool, @noescape code: ()->()) {
	let	shouldSetBackToFalse	=	state == false
	state	=	true
	code()
	if shouldSetBackToFalse {
		state	=	false
	}
}

//struct StackingSwitch {
//	func isEnabled() -> Bool {
//		return	_depth > 0
//	}
//	mutating func pushEnabled() {
//		_depth++
//	}
//	mutating func popEnabled() {
//		_depth--
//	}
//	mutating func callWithTemporaryEnabledContext(@noescape code: ()->()) {
//		pushEnabled()
//		code()
//		popEnabled()
//	}
//
//	private var _depth	=	0
//}
//extension StackingSwitch: BooleanType {
//	var boolValue: Bool {
//		get {
//			return	isEnabled()
//		}
//	}
//}