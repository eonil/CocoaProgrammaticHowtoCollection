//
//  AppDelegate.swift
//  ResizingCollectionViewCellExample
//
//  Created by Hoon H. on 2015/12/02.
//  Copyright © 2015 Eonil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	let mainWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
	let vc1 = VC1(collectionViewLayout: UICollectionViewFlowLayout())
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		mainWindow.rootViewController = vc1
		mainWindow.makeKeyAndVisible()
		return true
	}
}

class VC1: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	var heights = [44, 44, 44, 44] as [CGFloat]
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView!.registerClass(Cell1.self, forCellWithReuseIdentifier: "CELL")
	}
	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return heights.count
	}
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: heights[indexPath.item])
	}
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CELL", forIndexPath: indexPath)
		cell.backgroundColor = UIColor.redColor()
		return cell
	}
	override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		heights[indexPath.item] = heights[indexPath.item] == 44 ? 88 : 44

		// HERE IS THE CORE
		// ----------------
		// 1. Invalidate layout with these parameters.
		// 2. Invalidate it. This invalidation will just enqueue layout,
		//    and won't perform actual layout immediately. So we need to
		//    trigger the layout to make it animated.
		// 3. Call `performBatchUpdates` to trigger layout with animation.
		//    Actual layout will happen later asynchronously, but anyway,
		//    this method respect and captures external animation context.
		//    So we can wrap it with our own animation block to provide
		//    desired animation attributes.
		let ctx = UICollectionViewFlowLayoutInvalidationContext()
		ctx.invalidateItemsAtIndexPaths([indexPath])
		ctx.invalidateFlowLayoutDelegateMetrics = true
		ctx.invalidateFlowLayoutAttributes = true
		self.collectionView!.collectionViewLayout.invalidateLayoutWithContext(ctx)
		UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: { [weak self] () -> Void in
			guard self != nil else {
				return
			}
			// I don't know why, but `performBatchUpdates` takes external animaiton context parameters.
			self!.collectionView!.performBatchUpdates({ () -> Void in
			}) { (_: Bool) -> Void in
			}
		}) { _ in
		}
	}
}

class Cell1: UICollectionViewCell {
	override func didMoveToWindow() {
		super.didMoveToWindow()
		if window != nil {
			contentView.addSubview(_textView)
			_textView.text = "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n"
		}
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		_textView.frame = UIEdgeInsetsInsetRect(contentView.bounds, UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30))
		_textView.setContentOffset(CGPoint(x: 0, y: _textView.contentSize.height - _textView.bounds.height), animated: false)
	}
	private let _textView = UITextView()
}
