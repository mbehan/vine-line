//
//  ViewController.h
//  VineLine
//
//  Created by Michael Behan on 28/01/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VineLineDrawingView.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet VineLineDrawingView *drawingView;

- (IBAction)vineWidthWasEdited:(UISlider *)sender;
- (IBAction)branchSeperationWasEdited:(UISlider *)sender;
- (IBAction)leafSizeWasEdited:(UISlider *)sender;
- (IBAction)branchLengthWasEdited:(UISlider *)sender;

@end
