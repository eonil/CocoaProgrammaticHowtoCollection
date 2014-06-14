//
//  main.m
//  NoNIBCodeOnlyGUIAppBootstrapping
//
//  Created by Hoon H. on 2014/06/13.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>







/*********************************************************************************
 
 Make sure these stuffs.
 
 1.	Setup responder chain correctly so preview panel will begin at desired
	responder. In this case, a @c QuicklookController instance.
 
 2.	Always hold the provided panel instance in @c beginPreviewPanelControl: method.
	Otherwise, the panel instance seems to be lost, and a new one can be created, 
	and this brings wrong result.
 
 3.	Data-source and delegate doesn't have to be same with the responder. In this
	example, they're in one class for simplicity.
 
 See @c BoilerplateApplicationController class's @c applicationDidFinishLaunching:
 method to check how to setup responder chains correctly.
 
 *********************************************************************************/






@interface	QuicklookItem : NSObject <QLPreviewItem>
@property(readonly) NSURL * previewItemURL;
@property(readonly) NSString * previewItemTitle;
//@property(readonly) id previewItemDisplayState;
@end
@implementation QuicklookItem
- (id)initWithURL:(NSURL*)url
{
	self	=	[super init];
	if (self)
	{
		_previewItemURL		=	url;
		_previewItemTitle	=	@"The Title";
	}
	return	self;
}
@end

/*!
 Make sure that this responder is participating in a reponder chain.
 */
@interface	QuicklookController : NSResponder <QLPreviewPanelDataSource>
- (void)	displayPreview;
@end
@implementation QuicklookController
{
	QLPreviewPanel*	_holding_panel;
}
- (BOOL)acceptsFirstResponder
{
	return	YES;
}
- (BOOL)acceptsPreviewPanelControl:(QLPreviewPanel *)panel
{
	return	YES;
}
- (void)beginPreviewPanelControl:(QLPreviewPanel *)panel
{
	_holding_panel	=	panel;						///	You must hold a reference to the provided panel. Otherwise it won't worl propely!
	
//	_holding_panel.delegate		=	self;			///	Delegate is optional.
    _holding_panel.dataSource	=	self;			///	Data-source is required.
}

- (void)endPreviewPanelControl:(QLPreviewPanel *)panel
{
	_holding_panel	=	nil;
}
- (void)displayPreview
{
	[[QLPreviewPanel sharedPreviewPanel] makeKeyAndOrderFront:nil];
}
#pragma mark - QLPreviewPanelDataSource
- (NSInteger)numberOfPreviewItemsInPreviewPanel:(QLPreviewPanel *)panel
{
    return 2;
}
- (id <QLPreviewItem>)previewPanel:(QLPreviewPanel *)panel previewItemAtIndex:(NSInteger)index
{
	/*!
	 Doesn't need to keep the reference to the item. Items are treated as a value.
	 */
	
	if (index == 0)
	{
		return	[[QuicklookItem alloc] initWithURL:[[NSBundle mainBundle] URLForResource:@"PREVIEW-EXAMPLE-TEXT-FILE" withExtension:@"txt"]];
	}
	if (index == 1)
	{
		return	[[QuicklookItem alloc] initWithURL:[[NSBundle mainBundle] URLForResource:@"lena" withExtension:@"png"]];
	}
	abort();
}
@end






































@interface	BoilerplateApplicationController : NSResponder <NSApplicationDelegate>
@end
@implementation BoilerplateApplicationController
{
	NSWindow*				_main_window;
	QuicklookController*	_qc;
}
- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	_main_window	=	[[NSWindow alloc] init];
	[_main_window setStyleMask:NSResizableWindowMask | NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask];
	[_main_window setContentSize:CGSizeMake(400, 300)];
	[_main_window makeKeyAndOrderFront:self];
	
	
	
	////
	
	_qc				=	[[QuicklookController alloc] init];
	
	[self setNextResponder:_main_window];
	[_main_window setNextResponder:_qc];
	[_qc becomeFirstResponder];
	[_qc displayPreview];
	
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
