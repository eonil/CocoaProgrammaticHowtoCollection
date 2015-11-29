////
////  ViewController3.swift
////  TextChatUIExample
////
////  Created by Hoon H. on 2015/11/29.
////  Copyright © 2015 Eonil. All rights reserved.
////
//
//import UIKit
//
//class ViewController3: UIViewController {
//
//	// MARK: -
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		view.addSubview(_view1)
//		navigationItem.rightBarButtonItem	=	UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "EDITOR_endEditing:")
//	}
//	override func viewDidLayoutSubviews() {
//		super.viewDidLayoutSubviews()
//		_view1.frame	=	view.bounds
//	}
//	override func canBecomeFirstResponder() -> Bool {
//		return	true
//	}
//	override var inputAccessoryView: UIView? {
//		get {
//			return	_input1
//		}
//	}
//	override func disablesAutomaticKeyboardDismissal() -> Bool {
//		return	true
//	}
//
//	@objc
//	func EDITOR_endEditing(_: AnyObject?) {
//		becomeFirstResponder()
//	}
//
//
//
//
//
//	private let _view1	=	View1()
//	private let _input1	=	Input1()
//
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
