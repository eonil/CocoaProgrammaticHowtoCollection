//
//  BoilerplateWindowController.m
//  FileDragAndDrop
//
//  Created by Hoon H. on 2014/06/13.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "BoilerplateWindowController.h"
#import "DropTestView.h"

@interface BoilerplateWindowController ()
@end

@implementation BoilerplateWindowController
{
	NSWindow*				_main_window;
	DropTestView*	_ddtest_v;
}
- (id)initWithWindow:(NSWindow *)window
{
    self	=	[super initWithWindow:window];
    if (self)
	{
		_main_window	=	[[NSWindow alloc] init];
		[_main_window setStyleMask:NSResizableWindowMask | NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask];
		[_main_window setContentSize:CGSizeMake(400, 300)];
		[_main_window makeKeyAndOrderFront:self];
		
		_ddtest_v		=	[[DropTestView alloc] init];
		[_main_window setContentView:_ddtest_v];

		[[NSAlert alertWithMessageText:@"Try dragging a file into this window." defaultButton:@"OK" alternateButton:@"" otherButton:@"" informativeTextWithFormat:@""] runModal];
    }
    return self;
}
@end
