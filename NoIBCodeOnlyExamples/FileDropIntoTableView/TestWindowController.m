//
//  BoilerplateWindowController.m
//  FileDragAndDrop
//
//  Created by Hoon H. on 2014/06/13.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "TestWindowController.h"








/*********************************************
 
 
 The core parts are;
 
 @code
 [_tablev registerForDraggedTypes:@[NSFilenamesPboardType]];
 - (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation
 - (BOOL)tableView:(NSTableView *)tableView acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation
 @endcode
 
 @c NSTableView already handling the drag-and-drop, and provides its own version of drag-and-drop handling mechanism.
 Anyway you need to register the droppable type first. And then, provide @c ...validateDrop:... method and @c ...acceptDrop... method
 of @c NSTableViewDataSource protocol. Of course, don't forget to wire up the data-source object to the table-view.
 
 
 *********************************************/

















@interface TestWindowController ()
@end

@implementation TestWindowController
{
	NSWindow*				_main_window;
	NSScrollView*			_scrv;
	NSTableView*			_tablev;
	
	NSArray*				_list_items_data;
}
- (id)initWithWindow:(NSWindow *)window
{
    self	=	[super initWithWindow:window];
    if (self)
	{
		[self setup_other_boilerplates];

		//	Connect event handlers after all layout configurations.
		[_tablev setDataSource:self];
		[_tablev registerForDraggedTypes:@[NSFilenamesPboardType]];
		
		[[NSAlert alertWithMessageText:@"Try dragging a file into this window." defaultButton:@"OK" alternateButton:@"" otherButton:@"" informativeTextWithFormat:@""] runModal];
    }
    return self;
}

- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation
{
	return	NSDragOperationAll;
}
- (BOOL)tableView:(NSTableView *)tableView acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation
{
	NSPasteboard*	p1	=	[info draggingPasteboard];
	NSArray*		a1	=	[p1 propertyListForType:NSFilenamesPboardType];

	[[NSAlert alertWithMessageText:a1.description defaultButton:@"OK" alternateButton:@"" otherButton:@"" informativeTextWithFormat:@""] runModal];
	return	YES;
}








- (void)setup_other_boilerplates
{
	_main_window	=	[[NSWindow alloc] init];
	[_main_window setStyleMask:NSResizableWindowMask | NSClosableWindowMask | NSTitledWindowMask | NSMiniaturizableWindowMask];
	[_main_window setContentSize:CGSizeMake(400, 300)];
	[_main_window makeKeyAndOrderFront:self];
	
	_scrv			=	[[NSScrollView alloc] init];
	[_scrv setHasHorizontalScroller:YES];
	[_scrv setHasVerticalRuler:YES];
	
	NSTableColumn*	c1	=	[[NSTableColumn alloc] init];
	[[c1 headerCell] setStringValue:@"Col 1"];
	
	_tablev			=	[[NSTableView alloc] init];
	[_tablev addTableColumn:c1];
	
	//	Build hierarchy at last.
	[_scrv setDocumentView:_tablev];
	[_main_window setContentView:_scrv];

}
@end
