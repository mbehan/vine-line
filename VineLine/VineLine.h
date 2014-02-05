//
//  VineLine.h
//  VineLine
//
//  Created by Michael Behan on 28/01/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VineBranch.h"

@protocol VineLineDelegate <NSObject>

-(void)vineLineDidCreateBranch:(VineBranch *)branchPath;

@end

@interface VineLine : UIBezierPath

@property(nonatomic, weak)id delegate;
@property(nonatomic, retain, readonly)NSMutableArray *branchLines;
@property(nonatomic)float minBranchSeperation;
@property(nonatomic)float maxBranchLength;
@property(nonatomic)float leafSize;

@end

