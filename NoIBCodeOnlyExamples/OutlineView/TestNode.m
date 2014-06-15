//
//  TestNode.m
//  OutlineView
//
//  Created by Hoon H. on 2014/06/15.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "TestNode.h"

@implementation TestNode
{
	NSArray*	_subnodes;
}
- (NSArray *)subnodes
{
	if (_subnodes == nil)
	{
		_subnodes	=	[[NSArray alloc] init];
		
		NSUInteger	c	=	arc4random() % 10;
		for (NSUInteger i=0; i<c; i++)
		{
			_subnodes	=	[_subnodes arrayByAddingObject:[[TestNode alloc] init]];
		}
	}
	
	return	_subnodes;
}
@end
