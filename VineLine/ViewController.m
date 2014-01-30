//
//  ViewController.m
//  VineLine
//
//  Created by Michael Behan on 28/01/2014.
//  Copyright (c) 2014 Michael Behan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)vineWidthWasEdited:(UISlider *)sender {
    _drawingView.vineWidth = sender.value;
}

- (IBAction)branchSeperationWasEdited:(UISlider *)sender {
    _drawingView.branchSeperation = sender.value;
}

- (IBAction)leafSizeWasEdited:(UISlider *)sender {
    _drawingView.leafSize = sender.value;
}

- (IBAction)branchLengthWasEdited:(UISlider *)sender {
    _drawingView.branchLength = sender.value;
}
@end
