//
//  DragAndDropTestView.m
//  FileDragAndDrop
//
//  Created by Hoon H. on 2014/06/13.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "DragAndDropTestView.h"


/*!
 
 @c NSView conforms @c NSDraggingDestination protocol, and you can provide reactions to
 dropping by overriding methods defined in the protocol.
 
 */

@implementation DragAndDropTestView
- (id)initWithFrame:(NSRect)frame
{
    self	=	[super initWithFrame:frame];
    if (self)
	{
		[self registerForDraggedTypes:@[NSFilenamesPboardType]];
    }
    return self;
}
- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	return	NSDragOperationAll;		///	You should return proper list of possible operations.
}
- (void)draggingEnded:(id<NSDraggingInfo>)sender
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
	
	NSPasteboard*	p1	=	[sender draggingPasteboard];
	NSArray*		fs1	=	[p1 propertyListForType:NSFilenamesPboardType];
	
	/*!
	 See @c NSFilenamesPboardType to know what kind of data is being passed.
	 According to Apple's official manual, the type passes an array of string.
	 This is property-list type, so you should use @c propertyListForType method
	 to get the data.
	 */
	
	if (fs1.count > 0)
	{
		NSString*	fn1	=	fs1[0];
		[[self window] setTitleWithRepresentedFilename:fn1];
	}
	
	return	YES;
}
@end
