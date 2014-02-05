//
//  VineBranch.h
//  VineLine
//
//  Created by Michael Behan on 29/01/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VineBranch : UIBezierPath

-(id)initWithRandomPathFromPoint:(CGPoint)startPoint maxLength:(float)maxLength leafSize:(float)leafSize;

@end
