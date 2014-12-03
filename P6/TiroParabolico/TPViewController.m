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
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipe;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *pan;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *longPress;

@end

@implementation TPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.trajectoryView.speed = self.speedSlider.value;
    self.trajectoryView.angle = self.angleSlider.value;
    self.trajectoryView.distance = self.distanceSlider.value;
    
    UISwipeGestureRecognizer *sru = [[UISwipeGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(swipeAction:)];
    sru.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:sru];
    
    UISwipeGestureRecognizer *srd = [[UISwipeGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(swipeAction:)];
    srd.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:srd];
    
    
    [self.pan requireGestureRecognizerToFail:srd];
    [self.pan requireGestureRecognizerToFail:sru];

    
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

- (IBAction)swipeAction:(UISwipeGestureRecognizer *)sender {
    NSLog(@"has swypeado %d", sender.direction);
    float a=self.trajectoryView.angle;
    if(sender.direction ==UISwipeGestureRecognizerDirectionUp){
        a+= 5.0/180 *M_PI;
    }
    else if(sender.direction ==UISwipeGestureRecognizerDirectionDown){
        a-= 5.0/180 *M_PI;
    }
    self.trajectoryView.angle=a;
    NSLog(@"%f", a);
    self.angleSlider.value=self.trajectoryView.angle;
    
}

- (IBAction)panAction:(UIPanGestureRecognizer *)sender {
    
    self.trajectoryView.speed +=[sender translationInView:sender.view].x;
    
    
    [sender setTranslation:CGPointZero inView:sender.view];
    self.speedSlider.value=self.trajectoryView.speed;
    
    
    [self.trajectoryView setNeedsDisplay];
}
- (IBAction)longPressAction:(UILongPressGestureRecognizer *)sender {
    
    int constanteAjuste = 3;
    
    self.trajectoryView.distance = constanteAjuste*[sender locationInView:sender.view].x;
    
    self.distanceSlider.value=self.trajectoryView.distance;
    
    [self.trajectoryView setNeedsDisplay];
    
    
}

@end
