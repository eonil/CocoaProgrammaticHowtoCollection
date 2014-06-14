//
//  main.m
//  NoNIBCodeOnlyGUIAppBootstrapping
//
//  Created by Hoon H. on 2014/06/13.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import <Cocoa/Cocoa.h>






@interface	ApplicationController : NSResponder <NSApplicationDelegate>
@end

@implementation ApplicationController
{
	NSWindow*	_main_window;
}
/*!
 You should not create @c NSWindow or any other GUI component before app launching is finished.
 */
- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	NSLog(@"%@", @"Test OK.");
	
	{
		/*!
		 But it's OK to create after launching finished.
		 */
		_main_window	=	[[NSWindow alloc] init];
		[_main_window setStyleMask:NSResizableWindowMask | NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask];
		[_main_window setContentSize:CGSizeMake(400, 300)];
		[_main_window makeKeyAndOrderFront:self];
	}
	
	/*!
	 Now you booted up, but you have nothing, even there's no main-menu, so you
	 cannot quit using @c Command+Q.
	 */
}
- (void)userTapQuitMenu:(id)sender
{
	[[NSApplication sharedApplication] terminate:self];
}
@end








int main(int argc, const char * argv[])
{
	/*!
	 Never forget to make an autorelease-pool.
	 */
	@autoreleasepool
	{
		ApplicationController*		del1	=	[[ApplicationController alloc] init];
		NSApplication*	app1	=	[NSApplication sharedApplication];		///	Let it to be created by accessing it.
		[app1 setDelegate:del1];
		[app1 run];
	
		/*!
		 Calling of @c NSApplicationMain is not required.
		 */
//		return NSApplicationMain(argc, argv);
	}
}
