//
//  Conversation1.swift
//  ConversationUIExample
//
//  Created by Hoon H. on 2015/11/28.
//  Copyright © 2015 Eonil. All rights reserved.
//

import Foundation

func instantiateModel() -> Conversation1 {
	return	_Conversation1Impl()
}

protocol Conversation1: class {
	func getSegmentCount() -> Int
	func getSegmentAtIndex(index: Int) -> Segment1
	var onDidChange: (()->())? { get set } // Single-dispatch for simpler implementation.
}
protocol Segment1: class {
	func getText() -> String
}





private class _Conversation1Impl: Conversation1 {
	func getSegmentCount() -> Int {
		return	_segments.count
	}
	func getSegmentAtIndex(index: Int) -> Segment1 {
		return	_segments[index]
	}
	var onDidChange: (()->())?

	private var	_segments	=	Array<_SegmentImpl>((0..<64).map({ _ in return _SegmentImpl() }))
}

private class _SegmentImpl: Segment1 {
	func getText() -> String {
		return	_text
	}

	private var	_text		=	{
		let	n		=	random() % 128
		let	s		=	"\(n)"
		let	s1		=	Repeat(count: n, repeatedValue: s).joinWithSeparator(" ")
		return	s1
	}() as String
}