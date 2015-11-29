//
//  ViewController2.swift
//  ConversationUIExample
//
//  Created by Hoon H. on 2015/11/28.
//  Copyright © 2015 Eonil. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, KeyboardFrameTrackingControllerDelegate {

	// MARK: -
	override func viewDidLoad() {
		super.viewDidLoad()
		_reconfigure()
		_render(true)
	}
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		_collectionView.performBatchUpdates(nil) { [weak self] _ in
			guard self != nil else {
				return
			}
			callWithTemporaryTrueContext(&self!._shouldTrackKBD) {
				self!._render()
				self!._scrollToEnd(animateIfFarAway: false)
			}
		}
	}
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		_shouldTrackKBD	=	true
		_render()
	}
	override func viewWillDisappear(animated: Bool) {
		_shouldTrackKBD	=	false
		super.viewWillDisappear(animated)
	}
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		_render()
	}
	override func canBecomeFirstResponder() -> Bool {
		return	true
	}
	override var inputAccessoryView: UIView? {
		get {
			return	_input1
		}
	}
	override func disablesAutomaticKeyboardDismissal() -> Bool {
		return	true
	}





	// MARK: -
	@objc
	func scrollViewDidScroll(scrollView: UIScrollView) {
	}
	@objc
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return	1
	}
	@objc
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return	_model.getSegmentCount()
	}
	@objc
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let	cell	=	collectionView.dequeueReusableCellWithReuseIdentifier(Cell1.reuseIdentifier(), forIndexPath: indexPath) as! Cell1
		cell.segment	=	_model.getSegmentAtIndex(indexPath.item)
		return	cell
	}
	@objc
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return	_measureSizeOfItemAtIndex(indexPath.item)
	}
	func keyboardFrameTrakingControllerDidStartAnimatingKeyboardFrame(frame: (from: CGRect, to: CGRect)) {
		_render(false, keyboardMinYDelta: frame.to.minY - frame.from.minY)
	}
	func keyboardFrameTrakingControllerDidEndAnimatingKeyboardFrame(frame: (from: CGRect, to: CGRect)) {
	}
	@objc
	func EDITOR_endEditing(_: AnyObject?) {
		becomeFirstResponder()
	}















	// MARK: -
	private let _input1		=	Input1()
	private let _collectionView	=	UICollectionView(frame: CGRect.zero, collectionViewLayout: Layout1())
	private var _model		=	instantiateModel()
	private let _sizingCell		=	Cell1()

	private let _keyboardTracker	=	KeyboardFrameTrackingController()
	private var _shouldTrackKBD	=	false

	// MARK: -
	private func _reconfigure() {
		_model.onDidChange	=	{ [weak self] in
			self?._render(true)
		}
		_collectionView.dataSource	=	self
		_collectionView.delegate	=	self
		_collectionView.registerClass(Cell1.self, forCellWithReuseIdentifier: Cell1.reuseIdentifier())
		_collectionView.keyboardDismissMode	=	.Interactive
		view.addSubview(_collectionView)
		navigationItem.rightBarButtonItem	=	UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "EDITOR_endEditing:")
		_keyboardTracker.delegate		=	self
	}
	/// Renders current state to view tree.
	/// This is the only mutator to view tree.
	private func _render(dataChanged: Bool = false, keyboardMinYDelta: CGFloat = 0) {
		// We need top buffer. Otherwise cells will disappear when keyboard pops up.
		// To be safe for any circumstances, top buffer is just as long as `view.bound.height`.
		_collectionView.frame			=	CGRect(x: 0, y: -view.bounds.height, width: view.bounds.width, height: view.bounds.height * 2)
		if dataChanged {
			_collectionView.reloadData()
		}

		if _shouldTrackKBD {
			// Tracks keyboard movement precisely for any case.
//			 Unfortunately, this breaks when combined with `.Interactive` `keyboardDismissMode`.
//			let	lastInverseContentOffsetY	=	_collectionView.scrollableSize.height - _collectionView.contentOffset.y
//			let	keyboardMinY			=	_keyboardTracker.keyboardFrameInScreen?.minY ?? view.bounds.maxY
//			let	keyboardVisibleH		=	max(0, view.bounds.maxY - keyboardMinY)
//			let	topMargin			=	20 + 44 + view.bounds.height
//			_collectionView.scrollIndicatorInsets	=	UIEdgeInsets(top: topMargin, left: 0, bottom: keyboardVisibleH, right: 0)
//			_collectionView.contentInset		=	UIEdgeInsets(top: topMargin, left: 0, bottom: keyboardVisibleH, right: 0)
//			_collectionView.contentOffset.y		=	max(-topMargin, (_collectionView.scrollableSize.height + keyboardDelta) - lastInverseContentOffsetY)

			let	keyboardMinY			=	_keyboardTracker.keyboardFrameInScreen?.minY ?? view.bounds.maxY
			let	keyboardVisibleH		=	max(0, view.bounds.maxY - keyboardMinY)
			let	topMargin			=	20 + 44 + view.bounds.height
			let	edgeInsets			=	UIEdgeInsets(top: topMargin, left: 0, bottom: keyboardVisibleH, right: 0)
			_collectionView.scrollIndicatorInsets	=	edgeInsets
			_collectionView.contentInset		=	edgeInsets
//			Debug.log("keyboardVisibleH = \(keyboardVisibleH)")

			// Scrolls to the end only when keyboard pops up.
			// Does nothing when keyboard pushes down.
			if keyboardMinYDelta < 0 {
				_scrollToEnd(animateIfFarAway: true)
			}
		}
	}
	private func _scrollToEnd(animateIfFarAway animateIfFarAway: Bool = false) {
		let	segmentCount	=	_model.getSegmentCount()
		guard segmentCount > 0 else {
			return
		}
		let	lastIndexPath		=	NSIndexPath(forItem: segmentCount - 1, inSection: 0)
		let	lastSegmentIsNearby	=	_collectionView.scrollableSize.height - _collectionView.contentOffset.y < _collectionView.bounds.height
		if lastSegmentIsNearby {
			// Short distance. Just scrolls with outer context (expects keyboard) animation.
			_collectionView.scrollToItemAtIndexPath(lastIndexPath, atScrollPosition: .Bottom, animated: false)
		}
		else {
			// Long distance. Utilize animated scrolling method.
			_collectionView.scrollToItemAtIndexPath(lastIndexPath, atScrollPosition: .Bottom, animated: animateIfFarAway)
		}
	}

	// MARK: -
	private func _flowLayout() -> UICollectionViewFlowLayout {
		return	_collectionView.collectionViewLayout as! UICollectionViewFlowLayout
	}

	// MARK: -
	private func _measureSizeOfItemAtIndex(index: Int) -> CGSize {
		_sizingCell.segment	=	_model.getSegmentAtIndex(index)
		let	sz		=	_sizingCell.sizeThatFits(CGSize(width: _collectionView.bounds.width, height: CGFloat.max))
		let	sz1		=	CGSize(width: _collectionView.bounds.width, height: sz.height)
		return	sz1
	}

}




















