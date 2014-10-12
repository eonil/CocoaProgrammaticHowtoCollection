//
//  BoilerplateWindowController.m
//  FileDragAndDrop
//
//  Created by Hoon H. on 2014/06/13.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "TestWindowController.h"
#import "TestNode.h"







/*******************************************************************************************************************

 CAVEATS
 -------------------------------------------------------------------------------------------------------------------
 
 -	You have to set *outline-table-column* to show expander triangles.
	Use this method.
	@code
	-[NSOutlineView setOutlineTableColumn:]
	@endcode
 
 -	All the data-source items used in the tree must be retained yourself. Tree-view does not retain them for you even
	it needs to keep it. Seems to be related to some optimization stuffs.
 
 -	These methods are minimum requirements.
	@code
	- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
	- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
	- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
	- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
	@endcode
 
 ********************************************************************************************************************/

















@interface TestWindowController ()
@end

@implementation TestWindowController
{
	NSWindow*				_main_window;
	NSScrollView*			_scrv;
	NSOutlineView*			_treev;
	
	TestNode*				_root;
}
- (id)initWithWindow:(NSWindow *)window
{
    self	=	[super initWithWindow:window];
    if (self)
	{
		NSTableColumn*	c1	=	[[NSTableColumn alloc] init];
		[[c1 headerCell] setStringValue:@"Col 1"];
		
		_treev			=	[[NSOutlineView alloc] init];
		_root			=	[[TestNode alloc] init];
		
		[_treev addTableColumn:c1];
		[_treev setOutlineTableColumn:c1];
		
		////
		
		[_treev setDataSource:self];
		
		////
		
		[self setup_other_boilerplates];
    }
    return self;
}
- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
	return	[self outlineView:outlineView numberOfChildrenOfItem:item] > 0;
}
- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
	if (item == nil)
	{
		return	1;
	}
	if ([item isKindOfClass:[TestNode class]])
	{
		TestNode*	n1	=	item;
		return	[[n1 subnodes] count];
	}
	abort();
}
- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
	if (item == nil)
	{
		return	_root;
	}
	if ([item isKindOfClass:[TestNode class]])
	{
		TestNode*	n1	=	item;
		return	[[n1 subnodes] objectAtIndex:index];
	}
	abort();
}
- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
	if ([item isKindOfClass:[TestNode class]])
	{
		return	[item description];
	}
	abort();
}








- (void)setup_other_boilerplates
{
	_main_window	=	[[NSWindow alloc] init];
	[_main_window setStyleMask:NSResizableWindowMask | NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask];
	[_main_window setContentSize:CGSizeMake(400, 300)];
	[_main_window makeKeyAndOrderFront:self];
	
	_scrv			=	[[NSScrollView alloc] init];
	[_scrv setHasHorizontalScroller:YES];
	[_scrv setHasVerticalScroller:YES];
	
	//	Build hierarchy at last.
	[_scrv setDocumentView:_treev];
	[_main_window setContentView:_scrv];

}
@end
