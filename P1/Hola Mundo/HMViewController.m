//
//  HMViewController.m
//  Hola Mundo
//
//  Created by g011 DIT UPM on 12/09/13.
//  Copyright (c) 2013 g011 DIT UPM. All rights reserved.
//

#import "HMViewController.h"
#import <MapKit/MapKit.h>


@interface HMViewController ()
@property (weak, nonatomic) IBOutlet UILabel *msg;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation HMViewController

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
- (IBAction)mundoPressed:(UIButton *)sender {
    NSLog(@"Has pulsado mundo");
    self.msg.text = @"Mundo";
    MKCoordinateRegion reg = {{40.452445, -3.726162},
        {0.002,0.002}};
    [self.map setRegion:reg animated:YES];
    [self.map setMapType: MKMapTypeSatellite];
}
- (IBAction)holaPressed:(UIButton *)sender {
    NSLog(@"Has pulsado hola.");
    
    self.msg.text = @"Hola";
    self.msg.alpha = 0.5;
    self.slider.value = 0.5;
    [self.map setMapType: MKMapTypeHybrid];
}

- (IBAction)sorpresaPressed:(UIButton *)sender {
    NSLog(@"Has pulsado sorpresa");
    self.msg.text = @"Louvre";
    MKCoordinateRegion reg = {{48.86102222, 2.335825},
        {0.002,0.002}};
    [self.map setRegion:reg animated:YES];
    [self.map setMapType: MKMapTypeSatellite];
}

- (IBAction)sliderMoved:(UISlider *)sender {

    self.msg.alpha = sender.value;
}

@end
