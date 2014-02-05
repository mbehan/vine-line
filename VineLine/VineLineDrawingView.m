//
//  VineLineDrawingView.m
//  VineLine
//
//  Created by Michael Behan on 28/01/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import "VineLineDrawingView.h"
#import "VineLine.h"
#import <QuartzCore/QuartzCore.h>

@interface VineLineDrawingView()
{
    NSMutableArray *vineLines;
    UIColor *vineColor;
}
@end

@implementation VineLineDrawingView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        
        vineLines = [[NSMutableArray alloc] init];
        vineColor = [UIColor colorWithRed:78/255.0 green:154/255.0 blue:131/255.0 alpha:1];
        
        UIPanGestureRecognizer *pgr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        
        [self addGestureRecognizer:pgr];
        
        _leafSize = 10.0;
        _branchSeperation = 100.0;
        _vineWidth = 5.0;
        _branchLength = 50.0;
    }
    return self;
}

-(void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        VineLine *newVineLine = [[VineLine alloc] init];
        newVineLine.delegate = self;
        newVineLine.lineWidth = _vineWidth;
        newVineLine.minBranchSeperation = _branchSeperation;
        newVineLine.maxBranchLength = _branchLength;
        newVineLine.leafSize = _leafSize;
        [newVineLine moveToPoint:[gestureRecognizer locationInView:self]];
        
        [vineLines addObject:newVineLine];
    }
    else if(gestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        VineLine *currentLine = [vineLines lastObject];
        
        [currentLine addLineToPoint:[gestureRecognizer locationInView:self]];
    }
    else
    {
        
    }
    [self setNeedsDisplay];
    
}

-(void)vineLineDidCreateBranch:(VineBranch *)branchPath
{
    CAShapeLayer *branchShape = [CAShapeLayer layer];
    branchShape.path = branchPath.CGPath;
    branchShape.fillColor = [UIColor clearColor].CGColor;
    branchShape.strokeColor = vineColor.CGColor;
    branchShape.lineWidth = branchPath.lineWidth;
    
    [self.layer addSublayer:branchShape];
    
    CABasicAnimation *branchGrowAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    branchGrowAnimation.duration = 1.0;
    branchGrowAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    branchGrowAnimation.toValue = [NSNumber numberWithFloat:1.0];
    [branchShape addAnimation:branchGrowAnimation forKey:@"strokeEnd"];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    [vineColor setStroke];
    
    for(VineLine *vineLine in vineLines)
    {
        [vineLine stroke];
        /*
        for(UIBezierPath *branchLine in vineLine.branchLines)
        {
            [branchLine stroke];
        }
         */
    }
}


@end
