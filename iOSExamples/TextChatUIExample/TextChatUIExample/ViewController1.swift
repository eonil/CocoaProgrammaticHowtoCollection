////
////  ViewController1.swift
////  ConversationUIExample
////
////  Created by Hoon H. on 2015/11/28.
////  Copyright © 2015 Eonil. All rights reserved.
////
//
//import UIKit
//
//class ViewController1: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//
//	// MARK: -
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		_reconfigure()
//	}
//	override func viewDidAppear(animated: Bool) {
//		super.viewDidAppear(animated)
//		becomeFirstResponder()
//		_render()
//	}
//	override func canBecomeFirstResponder() -> Bool {
//		return	true
//	}
//	override var inputAccessoryView: UIView? {
//		get {
//			return	_input1
//		}
//	}
//
//
//	// MARK: -
//	@objc
//	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//		return	1
//	}
//	@objc
//	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		return	_model.getSegmentCount()
//	}
//	@objc
//	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//		let	cell	=	collectionView.dequeueReusableCellWithReuseIdentifier(Cell1.reuseIdentifier(), forIndexPath: indexPath) as! Cell1
//		cell.segment	=	_model.getSegmentAtIndex(indexPath.item)
//		return	cell
//	}
//	@objc
//	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//		return	_measureSizeOfItemAtIndex(indexPath.item)
//	}
////	@objc
////	override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
//////		_runCellHeightCaching()
////	}
////	@objc
////	override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//////		_stopCellHeightCaching()
////	}
////	@objc
////	override func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
////		super.scrollViewDidEndScrollingAnimation(scrollView)
//////		_stopCellHeightCaching()
////	}
//
//
//
//
//
//
//	private let _input1	=	Input1(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//
//
//
//
//
//
//
//	// MARK: -
//	private var _model	=	instantiateModel()
//	private let _sizingCell	=	Cell1()
//	private func _reconfigure() {
//		_model.onDidChange	=	{ [weak self] in
//			self?._render()
//		}
//		collectionView!.registerClass(Cell1.self, forCellWithReuseIdentifier: Cell1.reuseIdentifier())
//	}
//	private func _render() {
//		collectionView!.reloadData()
//	}
//
//	// MARK: -
//	private func _flowLayout() -> UICollectionViewFlowLayout {
//		return	collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
//	}
//
//	// MARK: -
//	private func _measureSizeOfItemAtIndex(index: Int) -> CGSize {
//		_sizingCell.segment	=	_model.getSegmentAtIndex(index)
//		let	sz		=	_sizingCell.sizeThatFits(CGSize(width: collectionView!.bounds.width, height: CGFloat.max))
//		let	sz1		=	CGSize(width: collectionView!.bounds.width, height: sz.height)
//		return	sz1
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
////	// MARK: -
////	private var _cellHeights	=	[CGFloat?]()
////	private var _isRunningCaching	=	false
////	private func _invalidateCellHeightCache() {
////		_cellHeights	=	Array(Repeat(count: _model.getSegmentCount(), repeatedValue: nil))
////	}
////	private func _runCellHeightCaching() {
////		guard _isRunningCaching == false else {
////			return
////		}
////		_isRunningCaching	=	true
////	}
////	private func _cacheCellHeightAtIndex(index: Int) {
////		assert(_cellHeights[index] == nil)
////		_sizingCell.segment	=	_model.getSegmentAtIndex(index)
////		let	sz		=	_sizingCell.sizeThatFits(CGSize(width: collectionView!.bounds.width, height: CGFloat.max))
////		let	sz1		=	CGSize(width: collectionView!.bounds.width, height: sz.height)
////		_cellHeights[index]	=	sz1.height
////	}
////	private func _stopCellHeightCaching() {
////		guard _isRunningCaching == true else {
////			return
////		}
////		_isRunningCaching	=	false
////	}
//
//
//
//
////	// MARK: -
////	private var _cacheMissCount	=	0
////	private var _cacheHitCount	=	0
////	private func _recordCacheHit() {
////		_cacheHitCount++
////		_printCacheQuality()
////	}
////	private func _recordCacheMiss() {
////		_cacheMissCount++
////		_printCacheQuality()
////	}
////	private func _printCacheQuality() {
////		let	r	=	CGFloat(_cacheHitCount) / CGFloat(_cacheHitCount + _cacheMissCount)
////		print("Cache hit rate: \(Int(round(r * 100)))%")
////	}
//}
//
////struct CacheQualityStatistics {
////	private var _cacheMissCount	=	0
////	private var _cacheHitCount	=	0
////	private func _recordCacheHit() {
////		_cacheHitCount++
////	}
////	private func _recordCacheMiss() {
////		_cacheMissCount++
////	}
////}
//
//
//
//
//
//
//
