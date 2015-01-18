Eonil/CocoaProgrammaticHowtoCollection
======================================
2014/06/13
2015/01/10
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




-	ComponentUsages 

	Contains Swift examples. Written and tested in OSX 10.10.

	-	Bootstrapping. How to make an empty AppKit application.
	-	SplitViewExample. How to use `NSSplitViewController`.
	-	TextInput. How to take international text input using `NSTextInputClient` mechanism.
	-	TextView. How to make `NSTextView` properly working with scrolling.
	-	OutlineViewExample. How to fully establish working `NSOutlineView`.
	-	BorderlessRoundWindowWithShadow. How to make a border-less window with round corners and proper shadow. A bit verbose.
	-	RegularDarkVibrantWindow. How to make a dark `NSWindow` with blurred transparent background. A bit verbose.
	-	CustomNSTextViewWithNSTextStorage. How to make a custom `NSTextView` with custom `NSTextStorage`. A bit verbose.
	-	CollectionView. How to use `NSCollectionView`.

-	ComponentUsagesInObjectiveC

	Contains Objective-C based examples. Written and tested in OSX 10.9.


-	NonUIStuffsExamples
	
	Contains non-UI stuff examples. Written and tested in OSX 10.9.















License
-------
This code is written by Hoon H. (a.k.a. Eonil), and licensed under MIT license.



Contribution
------------
The ultimate goal of this project is providing a collection of **minimal** examples for each single situations so I can imediately assemble them to figure out **precise** solution for my (and holpefully your) problems. 
It will be nice if you help me to improve this collection by reporting some issues, suggestions, questions or even a pull request! 









