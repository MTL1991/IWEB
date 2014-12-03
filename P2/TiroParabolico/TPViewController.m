//
//  TPViewController.m
//  tiroParabolico
//
//  Created by g011 DIT UPM on 03/10/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "TPViewController.h"
#import "ParabolicView.h"


@interface TPViewController ()

@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UISlider *angleSlider;
@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;
@property (weak, nonatomic) IBOutlet ParabolicView *trajectoryView;

@end

@implementation TPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.trajectoryView.speed = self.speedSlider.value;
    self.trajectoryView.angle = self.angleSlider.value;
    self.trajectoryView.distance = self.distanceSlider.value;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Acciones

- (IBAction)speedChange:(UISlider *)sender {
    NSLog(@"velodidad = %f",sender.value);
    self.trajectoryView.speed=sender.value;
    [self.trajectoryView setNeedsDisplay];
}


- (IBAction)angleChange:(UISlider *)sender {
    self.trajectoryView.angle=sender.value;
    [self.trajectoryView setNeedsDisplay];
    
    
}
- (IBAction)distanceChange:(UISlider *)sender {
    self.trajectoryView.distance=sender.value;
    [self.trajectoryView setNeedsDisplay];
}



@end
