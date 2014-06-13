//
//  main.m
//  NoNIBCodeOnlyGUIAppBootstrapping
//
//  Created by Hoon H. on 2014/06/13.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BoilerplateWindowController.h"





@interface	BoilerplateApplicationController : NSResponder <NSApplicationDelegate>
@end

@implementation BoilerplateApplicationController
{
	BoilerplateWindowController*	_main_wc;
}
- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	NSMenu*		m1	=	[[NSMenu alloc] initWithTitle:@""];
	NSMenuItem*	m2	=	[[NSMenuItem alloc] initWithTitle:@"" action:@selector(userTapQuitMenu:) keyEquivalent:@""];
	
	NSMenu*		m3	=	[[NSMenu alloc] initWithTitle:@""];
	NSMenuItem*	m4	=	[[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(userTapQuitMenu:) keyEquivalent:@"q"];
	
	[[NSApplication sharedApplication] setMainMenu:m1];
	[m1 addItem:m2];
	[m2 setSubmenu:m3];
	[m3 addItem:m4];
	
	////
	
	_main_wc	=	[[BoilerplateWindowController alloc] init];
}
- (void)userTapQuitMenu:(id)sender
{
	[[NSApplication sharedApplication] terminate:self];
}
@end

int main(int argc, const char * argv[])
{
	@autoreleasepool
	{
		BoilerplateApplicationController*		del1	=	[[BoilerplateApplicationController alloc] init];
		NSApplication*	app1	=	[NSApplication sharedApplication];	
		[app1 setDelegate:del1];
		[app1 run];
	}
}
