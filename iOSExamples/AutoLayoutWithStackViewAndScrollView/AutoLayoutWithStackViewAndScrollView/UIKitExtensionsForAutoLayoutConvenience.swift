//
//  UIKitExtensionsForAutoLayoutConvenience.swift
//  StackViewPlayground
//
//  Created by Hoon H. on 2016/06/17.
//  Copyright © 2016 Eonil. All rights reserved.
//

import UIKit

/// Designed only for convenience.
/// You cannot deinstall once installed constraints.
/// Anyway, installed constraints will be deinstalled automatically when the views die.
extension UIView {
    private func prepare() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    private func append(c: NSLayoutConstraint) {
        c.active = true
    }

    /// Pins size to a constant value.
    func pinSizeTo(width: CGFloat, _ height: CGFloat) {
        prepare()
        pinWidthTo(width)
        pinHeightTo(height)
    }
    /// Pins width to a constant value.
    func pinWidthTo(value: CGFloat) {
        prepare()
        append(NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: value))
    }
    /// Pins height to a constant value.
    func pinHeightTo(value: CGFloat) {
        prepare()
        append(NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: value))
    }
}

extension UIStackView {
    /// Pins left-side on super-view's left-side.
    func pinLeft(displacement: CGFloat = 0) {
        prepare()
        append(NSLayoutConstraint(item: self, attribute: .Left, relatedBy: .Equal, toItem: superview, attribute: .Left, multiplier: 1, constant: displacement))
    }
    /// Pins right-side on super-view's right-side.
    func pinRight(displacement: CGFloat = 0) {
        prepare()
        append(NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal, toItem: superview, attribute: .Right, multiplier: 1, constant: displacement))
    }
    /// Pins top-side on super-view's top-side.
    func pinTop(displacement: CGFloat = 0) {
        prepare()
        append(NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: superview, attribute: .Top, multiplier: 1, constant: displacement))
    }
    /// Pins bottom-side on super-view's bottom-side.
    func pinBottom(displacement: CGFloat = 0) {
        prepare()
        append(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: superview, attribute: .Bottom, multiplier: 1, constant: displacement))
    }
}
