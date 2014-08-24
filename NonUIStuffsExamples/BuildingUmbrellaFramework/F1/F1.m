//
//  F1.m
//  F1
//
//  Created by Hoon H. on 8/24/14.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "F1.h"
#import <Cocoa/Cocoa.h>

@implementation F1
+ (void)test
{
	NSFileHandle*	f1	=	[NSFileHandle fileHandleWithStandardOutput];
	
#if	TEST_DBG_MODE
	[f1 writeData:[@"F1 -- debug mode\n" dataUsingEncoding:NSUTF8StringEncoding]];
#else
	[f1 writeData:[@"F1 -- release mode\n" dataUsingEncoding:NSUTF8StringEncoding]];
#endif
}
@end
