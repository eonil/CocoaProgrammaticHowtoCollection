Eonil/CocoaProgrammaticHowtoCollection
======================================
2014/06/13
2015/01/10
2015/11/07
2016/09/25
Hoon H.

This shows how to create a Cocoa GUI app using only program code with no Interface Builder / Storyoard
stuffs. Apple sample codes are great, but in many cases it lacks programmatic-only way and overly complex.

It's arguable that which one of IB-ful or IB-less strategy is better. But it's also clear that the IB
sometimes doesn't fit to, work on or serve well some situations. This how-to examples are written for 
the situations.



This also contains some non-GUI stuffs lacked in Apple's documentation. 
For example, *Umbrella framework*.



These examples always aim minimal code and configuration, then what you see is all fully required
to do the job.




- ComponentUsages 

	Contains Swift examples. Written and tested in OSX 10.11. Some examples will continue to work also in 10.10
	but I didn't test them. Now all examples require Swift 3 to compile.

	- `Bootstrapping`. How to make an empty AppKit application.
	- `SplitViewExample`. How to use `NSSplitViewController`.
	- `TextInput`. How to take international text input using `NSTextInputClient` mechanism.
	- `TextView`. How to make `NSTextView` properly working with scrolling.
	- `OutlineViewExample`. How to fully establish working `NSOutlineView`.
    - `OutlineViewWithTreeController`. How to configure outline view using Cocoa binding.
	- `BorderlessRoundWindowWithShadow`. How to make a border-less window with round corners and proper shadow. A bit verbose.
	- `RegularDarkVibrantWindow`. How to make a dark `NSWindow` with blurred transparent background. A bit verbose.
	- `CustomNSTextViewWithNSTextStorage`. How to make a custom `NSTextView` with custom `NSTextStorage`. A bit verbose.
	- `CollectionView`. How to use `NSCollectionView`.
	- `NSTableViewExample`. How to make view-based `NSTableView` with reused component views.
	- `NSToolbar`. How to make and use `NSToolbar` within an `NSWindow` properly.
	- `ApplicationMenu`. How to replicate system-default Cocoa app menu.
	- `NSTextViewWithCustomInactiveSelectionBackgroundColor`. How to use custom inactive selection background color with `NSTextView`.
    - And some more... (not listed)


- ComponentUsagesInObjectiveC

	Contains some Objective-C based examples. Written and tested in OSX 10.9.
    I don't write Objective-C code anymore, so treat this as a legacy.



- NonUIStuffsExamples
	
	Contains non-UI stuff examples. Written and tested in OSX 10.9.

    - `BuildingUmbrellaFramework`.


- iOSExamples

	Contains iOS stuff examples. Written in Swift 2.x and tested in iOS 8.0.
    **NOT YET UPDATED FOR SWIFT 3**

    - `AutoLayoutWithStackViewAndScrollView`.
	- `AutosizingTableExample`. Shows how to enable autoresizing in tables 
          and cells.
    - `CameraDisplay`.
    - `UICollectionViewCustomLayout`.
	- `UICollectionViewCustomLayout`. Shows how to employ custom layout and 
          dynamic cell resizing based on content size with manual layout.
	- `TextChatUIExample`. Shows fully-fledged chat UI. This shows input box, 
          and supports scrolling reaction by keyboard appearance.
	- `ResizingCollectionViewCellExample`. Shows how to make resizing cell 
          with `UICollectionView`. This is different with `reloading` because 
          this technique does not involve cross-fade animation or 
          reinstantiation of cell views. So you even can keep a `UITextView` 
          in it while keeping it working as first-responder.
        - `AutoLayoutWithStackViewAndScrollView`. Shows how to use
          `UIStackView` and `UIScrollView` to layout easily.









License
-------
This code is written by these people, and licensed under MIT license.

- Hoon H. (`eonil`)
- Chui Tey (`teyc`)




Contribution
------------
The ultimate goal of this project is providing a collection of **minimal** examples for each single situations so I can imediately assemble them to figure out **precise** solution for my (and holpefully your) problems. 
It will be nice if you help me to improve this collection by reporting some issues, suggestions, questions or even a pull request!









