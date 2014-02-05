//
//  VineLine.m
//  VineLine
//
//  Created by Michael Behan on 28/01/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import "VineLine.h"

@interface VineLine()
{
    CGPoint firstPoint;
    CGPoint lastBranchPosition;
}

@end

@implementation VineLine

-(id)init
{
    self = [super init];
    if(self)
    {
        _branchLines = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)moveToPoint:(CGPoint)point
{
    [super moveToPoint:point];
    
    firstPoint = point;
}

-(void)addLineToPoint:(CGPoint)point
{
    [super addLineToPoint:point];
    
    float distanceFromPrevious;
    
    if([_branchLines count] == 0)
    {
        distanceFromPrevious = hypotf(point.x - firstPoint.x, point.y - firstPoint.y);
    }
    else
    {
        distanceFromPrevious = hypotf(point.x - lastBranchPosition.x, point.y - lastBranchPosition.y);
    }
    
    if(distanceFromPrevious > _minBranchSeperation)
    {
        VineBranch *newBranch = [[VineBranch alloc] initWithRandomPathFromPoint:point maxLength:_maxBranchLength leafSize:_leafSize];
        newBranch.lineWidth = self.lineWidth / 2.0;
        
        [_branchLines addObject:newBranch];
        [_delegate vineLineDidCreateBranch:newBranch];
        lastBranchPosition = point;
    }
}

@end
