//
//  main.m
//  NoNIBCodeOnlyGUIAppBootstrapping
//
//  Created by Hoon H. on 2014/06/13.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import <Cocoa/Cocoa.h>




/*******************************************************************************
 
 CAVEATS
 -------
 
 -	Make sure that you have at least one tool in the toolbar.
	Otherwise toolbar will show strange behaviors, and initially
	hidden.
 
 -	Toolbar identifier is @b required . Not optional. Unfortunately, Cocoa/Xcode
	does not warn this for you. Maybe empy identifier is a valie state for some
	purpose. Don't forget to set identifier, otherwise your toolbar will not work
	or even visible.
 
		[[NSToolbar alloc] initWithIdentifier:EXAMPLE_TOOLBAR_ID]
 
 -	Though they're marked as @c @optional , but actually these delegate methods
	are @c @required .
 
		- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar
		- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar
		- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
 
	Don't worry. Cocoa will warn you if you run without these methods. (at least on
	my Mac!)
 
 
 FEATURE DETAILS
 ---------------
 
 -	If you don't set target/action on tool-item, it will be shown as disabled state.
	You can utilize this to make it intentionally disabled.
 
 *******************************************************************************/









NSString* const		EXAMPLE_TOOLBAR_ID		=	@"EXAMPLE/TOOLBAR/MAIN";
NSString* const		EXAMPLE_TOOL_TEST_ID	=	@"EXAMPLE/TOOL/TEST";


@interface	ExampleToolbarController1 : NSObject <NSToolbarDelegate>
@property	(readonly,nonatomic,strong)		NSToolbar*		toolbar;
@end
@implementation ExampleToolbarController1
- (id)init
{
	self	=	[super init];
	if (self)
	{
		_toolbar	=	[[NSToolbar alloc] initWithIdentifier:EXAMPLE_TOOLBAR_ID];
		[_toolbar setDelegate:self];
	}
	return	self;
}
- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar
{
	return	@[EXAMPLE_TOOL_TEST_ID];
}
- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar
{
	return	@[EXAMPLE_TOOL_TEST_ID];
}
- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
	if ([itemIdentifier isEqualToString:EXAMPLE_TOOL_TEST_ID])
	{
		NSToolbarItem*	item1	=	[[NSToolbarItem alloc] initWithItemIdentifier:EXAMPLE_TOOL_TEST_ID];
		item1.label				=	@"Test!";
		item1.target			=	self;
		item1.action			=	@selector(userClickTest:);
		return	item1;
	}

	abort();
}
- (void)userClickTest:(id)sender
{
	[[NSAlert alertWithMessageText:@"Test OK!" defaultButton:@"OK" alternateButton:@"" otherButton:@"" informativeTextWithFormat:@""] runModal];
}
@end

































//	Anything below is all boilerplate code.


@interface	BoilerplateApplicationController : NSResponder <NSApplicationDelegate>
- (void)userTapQuitMenu:(id)sender;
@end

@implementation BoilerplateApplicationController
{
	NSWindow*					_main_window;
	ExampleToolbarController1*	_toolbar_con;
}
- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	{
		_main_window	=	[[NSWindow alloc] init];
		[_main_window setStyleMask:NSResizableWindowMask | NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask];
		[_main_window setContentSize:CGSizeMake(400, 300)];
		[_main_window makeKeyAndOrderFront:self];
		
		NSCAssert([[NSApplication sharedApplication] mainMenu] == nil, @"An application should have no main-menu at first.");
		
		SEL			s1	=	NSSelectorFromString(@"userTapQuitMenu:");		//	Made from a string to avoid warning.
		
		NSMenu*		m1	=	[[NSMenu alloc] initWithTitle:@"Menu 1"];
		NSMenuItem*	m2	=	[[NSMenuItem alloc] initWithTitle:@"Item 2" action:s1 keyEquivalent:@""];
		
		NSMenu*		m3	=	[[NSMenu alloc] initWithTitle:@"Menu 3"];
		NSMenuItem*	m4	=	[[NSMenuItem alloc] initWithTitle:@"Item 4" action:s1 keyEquivalent:@"q"];
		
		[[NSApplication sharedApplication] setMainMenu:m1];
		[m1 addItem:m2];
		[m2 setSubmenu:m3];
		[m3 addItem:m4];
		
		////
		
		_toolbar_con	=	[[ExampleToolbarController1 alloc] init];
		_main_window.toolbar	=	_toolbar_con.toolbar;
	}
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
		NSApplication*	app1	=	[NSApplication sharedApplication];		///	Let it to be created by accessing it.
		[app1 setDelegate:del1];
		[app1 run];
	}
}
