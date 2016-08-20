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
    private var svh: NSLayoutConstraint?

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
        scheduleAnimation()
        return true
    }
    private func setupDemo() {
        view.addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).setAlmostRequiredAndActivate()
        sv.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).setAlmostRequiredAndActivate()
        sv.widthAnchor.constraintEqualToAnchor(view.widthAnchor).setAlmostRequiredAndActivate()
        svh = sv.heightAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 1)
        svh?.setAlmostRequiredAndActivate()
        sv.addArrangedSubview(a)
        sv.addArrangedSubview(b)
        sv.addArrangedSubview(c)
        sv.addArrangedSubview(d)
        a.widthAnchor.constraintEqualToConstant(50).setAlmostRequiredAndActivate()
        b.widthAnchor.constraintEqualToAnchor(c.widthAnchor, multiplier: 2).setAlmostRequiredAndActivate()
        d.widthAnchor.constraintEqualToConstant(50).setAlmostRequiredAndActivate()
        a.backgroundColor = UIColor.redColor()
        b.backgroundColor = UIColor.greenColor()
        c.backgroundColor = UIColor.blueColor()
        d.backgroundColor = UIColor.magentaColor()

        // Explicitly layout here to avoid deferred layout by scheduled animation.
        sv.layoutIfNeeded()
    }
    private func scheduleAnimation() {
        UIView.animateWithDuration(1, delay: 3, options: [], animations: { [weak self] in
            // This doesn't seem to cause actual layout immediately, but eventually.
            // Anyway I don't know when the actual layout would happen, so it's still
            // possible to happen immediately.
            // To be defensive to the case, I just set this parameter in the animation block.
            self?.svh?.constant -= 100
            // Force layout immediately to ensure animation.
            self?.sv.layoutIfNeeded()
        }) { (_: Bool) in
        }
    }
}

extension NSLayoutConstraint {
    func setAlmostRequiredAndActivate() {
        priority = UILayoutPriorityRequired - 1
        active = true
    }
}




