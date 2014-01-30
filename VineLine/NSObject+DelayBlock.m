//
//  NSObject+DelayBlock.m
//  VineLine
//
//  Created by Michael Behan on 29/01/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import "NSObject+DelayBlock.h"

@implementation NSObject (DelayBlock)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
	int64_t delta = (int64_t)(1.0e9 * delay);
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
}

@end
