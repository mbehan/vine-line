//
//  NSObject+DelayBlock.h
//  VineLine
//
//  Created by Michael Behan on 29/01/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DelayBlock)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
