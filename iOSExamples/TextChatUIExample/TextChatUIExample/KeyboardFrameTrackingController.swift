//
//  KeyboardFrameTrackingController.swift
//  ConversationUIExample
//
//  Created by Hoon H. on 2015/11/28.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardFrameTrackingControllerDelegate: class {
	func keyboardFrameTrakingControllerDidStartAnimatingKeyboardFrame(frame: (from: CGRect, to: CGRect))
	func keyboardFrameTrakingControllerDidEndAnimatingKeyboardFrame(frame: (from: CGRect, to: CGRect))
}
final class KeyboardFrameTrackingController {

	// MARK: -
	static func initiate() {
		assert(UIApplication.sharedApplication().windows.count == 0, "You must call this method before any `UIWindow` to be created.")
		_register()
	}
	static func terminate() {
		assert(UIApplication.sharedApplication().windows.count == 0, "You must call this method after all `UIWindow` deallocated.")
		_deregister()
	}


	// MARK: -
	weak var delegate: KeyboardFrameTrackingControllerDelegate?

	// MARK: -
	init() {
		assert(NSThread.isMainThread())
		assert(_observerContext1 != nil, "You must call `initiate` at a proper timing. See the method for more details.")
		_allControllers.append(self)
	}
	deinit {
		assert(NSThread.isMainThread())
		assert(_observerContext1 != nil, "You must call `initiate` at a proper timing. See the method for more details.")
		if let idx = _allControllers.indexOf({ $0 === self }) {
			_allControllers.removeAtIndex(idx)
		}
		else {
			fatalError()
		}
	}

	// MARK: -
	var keyboardFrameInScreen: CGRect? {
		get {
			assert(NSThread.isMainThread())
			return	_keyboardFrameInScreen
		}
	}
}










private var _observerContext1: AnyObject?
private var _observerContext2: AnyObject?
private var _keyboardFrameInScreen: CGRect?
private var _allControllers: [KeyboardFrameTrackingController] = []

private func _register() {
	assert(NSThread.isMainThread())
	_observerContext1 = NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillChangeFrameNotification, object: nil, queue: NSOperationQueue.mainQueue()) { _process($0) }
	_observerContext2 = NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardDidChangeFrameNotification, object: nil, queue: NSOperationQueue.mainQueue()) { _process($0) }
}
private func _deregister() {
	assert(NSThread.isMainThread())
	NSNotificationCenter.defaultCenter().removeObserver(_observerContext2!)
	NSNotificationCenter.defaultCenter().removeObserver(_observerContext1!)
}
private func _process(n: NSNotification) {
	switch n.name {
	case UIKeyboardWillChangeFrameNotification:
		let	fromFrame	=	(n.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
		let	toFrame		=	(n.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
//		let	duration	=	(n.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSValue) as! CGFloat
		_keyboardFrameInScreen	=	toFrame
		for kc in _allControllers {
			kc.delegate?.keyboardFrameTrakingControllerDidStartAnimatingKeyboardFrame((fromFrame, toFrame))
		}

	case UIKeyboardDidChangeFrameNotification:
		let	fromFrame	=	(n.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
		let	toFrame		=	(n.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
//		let	duration	=	(n.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSValue) as! CGFloat
		_keyboardFrameInScreen	=	toFrame
		for kc in _allControllers {
			kc.delegate?.keyboardFrameTrakingControllerDidEndAnimatingKeyboardFrame((fromFrame, toFrame))
		}
	default:
		fatalError()
	}
}

















