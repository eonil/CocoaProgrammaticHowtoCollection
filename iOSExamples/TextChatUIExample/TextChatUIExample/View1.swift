////
////  View1.swift
////  TextChatUIExample
////
////  Created by Hoon H. on 2015/11/29.
////  Copyright © 2015 Eonil. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class View1: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, KeyboardFrameTrackingControllerDelegate {
//	
//	override func didMoveToWindow() {
//		super.didMoveToWindow()
//		if window != nil {
//			_reconfigure()
//			_render(true, keyboardMinYDelta: 0)
//			_collectionView.performBatchUpdates(nil) { [weak self] _ in
//				assert(self!._collectionView.contentSize.height > 0)
//				self!._scrollToEnd()
//			}
//		}
//	}
//	override func willMoveToWindow(newWindow: UIWindow?) {
//		if window != nil {
//		}
//		super.willMoveToWindow(newWindow)
//	}
//	override func layoutSubviews() {
//		super.layoutSubviews()
//		_render()
//	}
//
//
//
//
//
//
//
//
//	// MARK: -
//	@objc
//	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//		return	1
//	}
//	@objc
//	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		return	_model.getSegmentCount()
//	}
//	@objc
//	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//		let	cell	=	collectionView.dequeueReusableCellWithReuseIdentifier(Cell1.reuseIdentifier(), forIndexPath: indexPath) as! Cell1
//		cell.segment	=	_model.getSegmentAtIndex(indexPath.item)
//		return	cell
//	}
//	@objc
//	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//		return	_measureSizeOfItemAtIndex(indexPath.item)
//	}
//	func keyboardFrameTrakingControllerDidStartAnimatingKeyboardFrame(frame: (from: CGRect, to: CGRect)) {
//		// Don't react to keyboard event while disappearing.
//		guard _isDisappeared == false else {
//			return
//		}
//
//		_render(false, keyboardMinYDelta: frame.to.minY - frame.from.minY)
//	}
//	func keyboardFrameTrakingControllerDidEndAnimatingKeyboardFrame(frame: (from: CGRect, to: CGRect)) {
//	}
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
//	// MARK: -
//	private let _collectionView	=	UICollectionView(frame: CGRect.zero, collectionViewLayout: Layout1())
//	private var _model		=	instantiateModel()
//	private let _sizingCell		=	Cell1()
//	private let _keyboardTracker	=	KeyboardFrameTrackingController()
//	private var _isDisappeared	=	false
//
//
//
//
//
//
//
//
//	private func _reconfigure() {
//		_model.onDidChange	=	{ [weak self] in
//			self?._render(true)
//		}
//		_collectionView.dataSource	=	self
//		_collectionView.delegate	=	self
//		_collectionView.registerClass(Cell1.self, forCellWithReuseIdentifier: Cell1.reuseIdentifier())
//		_collectionView.keyboardDismissMode	=	.Interactive
//		addSubview(_collectionView)
//		_keyboardTracker.delegate	=	self
//	}
//	private func _render(dataChanged: Bool = false, keyboardMinYDelta: CGFloat = 0) {
//		// We need top buffer. Otherwise cells will disappear when keyboard pops up.
//		// To be safe for any circumstances, top buffer is just as long as `view.bound.height`.
//		_collectionView.frame			=	CGRect(x: 0, y: -bounds.height, width: bounds.width, height: bounds.height * 2)
//		if dataChanged {
//			_collectionView.reloadData()
//		}
//
//		let	keyboardMinY			=	_keyboardTracker.keyboardFrameInScreen?.minY ?? bounds.maxY
//		let	keyboardVisibleH		=	max(0, bounds.maxY - keyboardMinY)
//		let	topMargin			=	20 + 44 + bounds.height
//		let	edgeInsets			=	UIEdgeInsets(top: topMargin, left: 0, bottom: keyboardVisibleH, right: 0)
//		_collectionView.scrollIndicatorInsets	=	edgeInsets
//		_collectionView.contentInset		=	edgeInsets
//		Debug.log("keyboardVisibleH = \(keyboardVisibleH)")
//
//		// Scrolls to the end only when keyboard pops up.
//		// Does nothing when keyboard pushes down.
//		if keyboardMinYDelta < 0 {
//			_scrollToEnd(animateIfFarAway: true)
//		}
//	}
//	private func _scrollToEnd(animateIfFarAway animateIfFarAway: Bool = false) {
//		print(_collectionView.contentInset)
//		let	segmentCount	=	_model.getSegmentCount()
//		guard segmentCount > 0 else {
//			return
//		}
//		let	lastIndexPath		=	NSIndexPath(forItem: segmentCount - 1, inSection: 0)
//		let	lastSegmentIsNearby	=	_collectionView.scrollableSize.height - _collectionView.contentOffset.y < _collectionView.bounds.height
//		if lastSegmentIsNearby {
//			// Short distance. Just scrolls with outer context (expects keyboard) animation.
//			_collectionView.scrollToItemAtIndexPath(lastIndexPath, atScrollPosition: .Bottom, animated: false)
//		}
//		else {
//			// Long distance. Utilize animated scrolling method.
//			_collectionView.scrollToItemAtIndexPath(lastIndexPath, atScrollPosition: .Bottom, animated: animateIfFarAway)
//		}
//	}
//
//	// MARK: -
//	private func _flowLayout() -> UICollectionViewFlowLayout {
//		return	_collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//	}
//
//	// MARK: -
//	private func _measureSizeOfItemAtIndex(index: Int) -> CGSize {
//		_sizingCell.segment	=	_model.getSegmentAtIndex(index)
//		let	sz		=	_sizingCell.sizeThatFits(CGSize(width: _collectionView.bounds.width, height: CGFloat.max))
//		let	sz1		=	CGSize(width: _collectionView.bounds.width, height: sz.height)
//		return	sz1
//	}
//
//}
//
//
//
//
