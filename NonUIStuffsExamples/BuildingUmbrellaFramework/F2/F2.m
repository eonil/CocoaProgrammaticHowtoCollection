//
//  F2.m
//  F2
//
//  Created by Hoon H. on 8/24/14.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "F2.h"
#import <Cocoa/Cocoa.h>

@implementation F2
+ (void)test
{
	NSFileHandle*	f1	=	[NSFileHandle fileHandleWithStandardOutput];
	
#if	TEST_DBG_MODE
	[f1 writeData:[@"F2 -- debug mode\n" dataUsingEncoding:NSUTF8StringEncoding]];
#else
	[f1 writeData:[@"F2 -- release mode\n" dataUsingEncoding:NSUTF8StringEncoding]];
#endif
}
@end
