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
    CGPoint lastPoint;
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
    
    float distanceFromCurrentPointOnVineToLastBranch;
    
    if([_branchLines count] == 0)
    {
        distanceFromCurrentPointOnVineToLastBranch = hypotf(point.x - firstPoint.x, point.y - firstPoint.y);
    }
    else
    {
        distanceFromCurrentPointOnVineToLastBranch = hypotf(point.x - lastBranchPosition.x, point.y - lastBranchPosition.y);
    }
    
    if(distanceFromCurrentPointOnVineToLastBranch > _minBranchSeperation)
    {
        VineBranch *newBranch = [[VineBranch alloc] init];
        newBranch.lineWidth = self.lineWidth / 2.0;
        [newBranch moveToPoint:point];
        
        
        CGPoint branchEnd = CGPointMake(point.x + arc4random_uniform(_maxBranchLength * 2) - _maxBranchLength,point.y + arc4random_uniform(_maxBranchLength * 2) - _maxBranchLength);
        CGPoint brachControl1 = CGPointMake(branchEnd.x + arc4random_uniform(_maxBranchLength) - _maxBranchLength / 2,branchEnd.y + arc4random_uniform(_maxBranchLength) - _maxBranchLength / 2);
        CGPoint branchControl2 = CGPointMake(branchEnd.x + arc4random_uniform(_maxBranchLength / 2) - _maxBranchLength / 4,branchEnd.y + arc4random_uniform(_maxBranchLength / 2) - _maxBranchLength / 4);
        
        [newBranch addCurveToPoint:branchEnd controlPoint1:brachControl1 controlPoint2:branchControl2];
        
        newBranch.endPoint = branchEnd;
        
        [_branchLines addObject:newBranch];
        [_delegate vineLineDidCreateBranch:newBranch];
        lastBranchPosition = point;
    }
    
    lastPoint = point;
}

@end
