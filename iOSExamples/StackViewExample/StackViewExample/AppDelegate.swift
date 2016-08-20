//
//  AppDelegate.swift
//  StackViewExample
//
//  Created by Hoon H. on 2016/08/20.
//  Copyright © 2016 Eonil. All rights reserved.
//

import UIKit

@UIApplicationMain
class ApplicationViewController: UIViewController, UIApplicationDelegate {
    private let mainWindow = UIWindow()

    private let sv = UIStackView()
    private let a = UIView()
    private let b = UIView()
    private let c = UIView()
    private let d = UIView()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        mainWindow.screen = UIScreen.mainScreen()
        mainWindow.frame = UIScreen.mainScreen().bounds
        mainWindow.makeKeyAndVisible()
        mainWindow.rootViewController = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraintEqualToAnchor(mainWindow.centerXAnchor).setAlmostRequiredAndActivate()
        view.centerYAnchor.constraintEqualToAnchor(mainWindow.centerYAnchor).setAlmostRequiredAndActivate()
        view.widthAnchor.constraintEqualToAnchor(mainWindow.widthAnchor).setAlmostRequiredAndActivate()
        view.heightAnchor.constraintEqualToAnchor(mainWindow.heightAnchor).setAlmostRequiredAndActivate()
        view.backgroundColor = UIColor.whiteColor()
        setupDemo()
        return true
    }
    private func setupDemo() {
        view.addSubview(sv)
        /// - Note: `translatesAutoresizingMaskIntoConstraints` sets masking translation of the target object. Not superview.
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).setAlmostRequiredAndActivate()
        sv.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).setAlmostRequiredAndActivate()
        sv.widthAnchor.constraintEqualToAnchor(view.widthAnchor).setAlmostRequiredAndActivate()
        sv.heightAnchor.constraintEqualToAnchor(view.heightAnchor).setAlmostRequiredAndActivate()
        sv.addArrangedSubview(a)
        sv.addArrangedSubview(b)
        sv.addArrangedSubview(c)
        sv.addArrangedSubview(d)

        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        // DEMO CORE: This is all we have to set to set them up.
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        a.widthAnchor.constraintEqualToConstant(50).setAlmostRequiredAndActivate()
        b.widthAnchor.constraintEqualToAnchor(c.widthAnchor, multiplier: 2).setAlmostRequiredAndActivate()
        d.widthAnchor.constraintEqualToConstant(50).setAlmostRequiredAndActivate()
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        // Mark all subviews to identify them visually.
        a.backgroundColor = UIColor.redColor()
        b.backgroundColor = UIColor.greenColor()
        c.backgroundColor = UIColor.blueColor()
        d.backgroundColor = UIColor.magentaColor()
    }
}

extension NSLayoutConstraint {
    func setAlmostRequiredAndActivate() {
        priority = UILayoutPriorityRequired - 1
        active = true
    }
}




