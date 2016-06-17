//
//  ExampleViewController.swift
//  AutoLayoutWithStackViewAndScrollView
//
//  Created by Hoon H. on 2016/06/18.
//  Copyright © 2016 Eonil. All rights reserved.
//

import UIKit

/// This example shows 3 things with Auto Layout.
///
/// 1. How to make a `UITextView` that resizes itself by its content.
/// 2. How to use `UIStackView` to place views top to bottom.
/// 3. How to make `UIScrollView.contentSize` automatically track its content size.
///
/// First, #1 is easy. `UITextView` is a `UIScrollView`, and `UIScrollView` just behaves like plain
/// `UIView` if `scrollEnabled` is set to `false`.
/// This solution is described [here](http://stackoverflow.com/a/21287306/246776).
///
/// To make `UIStackView` to work, you have to use Auto Layout for all related views.
/// `UIStackView` resizes itself automatically to fit to its content views.
/// So, just pin its left, right, top to make view to flow top to bottom.
///
/// Anyway, this is a bit different in a `UIScrollView`. Because scroll-view behaves differently
/// with Auto Layout, and you actually have to pin all four sides to make stack-view to work
/// as expected. `UIScrollView` seems have low priority, so it actually shrinks its internal
/// something to shrink to its content if its content if pinned to all four sides.
/// So, if need to pin all four sides to make scroll-view content-size to be adjusted automatically
/// to its contained stack-view. Then, stack-view will resize itself to its contents.
/// This behavior is explained [here](https://developer.apple.com/library/ios/technotes/tn2154/_index.html).
///
/// * Note that `UIStackView` doesn't perform any drawing, so it cannot have background-color.
///
final class ExampleViewController: UIViewController {

    let v1 = UIView(bg: UIColor.redColor())
    let v2 = UITextView(bg: UIColor.greenColor())
    let v3 = UIView(bg: UIColor.blueColor())
    let sv = UIStackView()
    let scrollView = UIScrollView()
    let bt = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        v2.text = "Type some text here to resize `UITextView`..."
        v2.scrollEnabled = false

        sv.axis = .Vertical
        sv.alignment = .Center
        sv.layoutMarginsRelativeArrangement = true
        sv.addArrangedSubview(v1)
        sv.addArrangedSubview(v2)
        sv.addArrangedSubview(v3)
        scrollView.addSubview(sv)
        view.addSubview(scrollView)

        v1.pinSizeTo(50, 100)
        v2.pinWidthTo(50)
        v3.pinSizeTo(50, 100)

        /// `UIStackView` automatically shrinks its size to fit to its content.
        /// If we pin left/right of stack-view to scroll-view, it's no-op because
        /// scroll-view has special behavior that fits its content-size to its content.
        /// So, we need to set stack-view width manually.
        sv.pinWidthTo(100)
        //        sv.pinLeft()
        //        sv.pinRight()
        sv.pinTop()
        sv.pinBottom()

        scrollView.frame = CGRect(x: 00, y: 0, width: 320-100, height: 300)
        scrollView.backgroundColor = UIColor.blackColor()

        bt.frame = CGRect(x: 320-100, y: 0, width: 100, height: 100)
        bt.addTarget(self, action: #selector(test1), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(bt)
        view.backgroundColor = UIColor.whiteColor()
    }
    @objc
    func test1() {
        v2.text = "AA"
    }
}

extension UIView {
    convenience init(bg: UIColor) {
        self.init()
        self.backgroundColor = bg
    }
}





