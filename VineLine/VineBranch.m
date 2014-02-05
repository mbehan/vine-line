//
//  VineBranch.m
//  VineLine
//
//  Created by Michael Behan on 29/01/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import "VineBranch.h"

@implementation VineBranch

-(id)initWithRandomPathFromPoint:(CGPoint)startPoint maxLength:(float)maxLength leafSize:(float)leafSize
{
    self = [super init];
    if(self)
    {
        [self moveToPoint:startPoint];
        
        CGPoint branchEnd = CGPointMake(startPoint.x + arc4random_uniform(maxLength * 2) - maxLength,startPoint.y + arc4random_uniform(maxLength * 2) - maxLength);
        CGPoint brachControl1 = CGPointMake(branchEnd.x + arc4random_uniform(maxLength) - maxLength / 2,branchEnd.y + arc4random_uniform(maxLength) - maxLength / 2);
        CGPoint branchControl2 = CGPointMake(branchEnd.x + arc4random_uniform(maxLength / 2) - maxLength / 4,branchEnd.y + arc4random_uniform(maxLength / 2) - maxLength / 4);
        
        [self addCurveToPoint:branchEnd controlPoint1:brachControl1 controlPoint2:branchControl2];
        
        UIBezierPath* leafPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(branchEnd.x - leafSize/2.0, branchEnd.y - leafSize/2.0, leafSize, leafSize)];
        
        [self appendPath:leafPath];
    }
    return self;
}

@end
