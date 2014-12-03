//
//  PruebaDrawViewController.m
//  Prueba Draw
//
//  Created by Manuel on 01/12/13.
//  Copyright (c) 2013 Manuel. All rights reserved.
//

#import "PruebaDrawViewController.h"
#import "PruebaDrawView.h"

@interface PruebaDrawViewController ()
@property (strong, nonatomic) IBOutlet UISlider *sliderAltura;
@property (strong, nonatomic) IBOutlet PruebaDrawView *viewCirculo;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panRadio;

@end

@implementation PruebaDrawViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.viewCirculo.altura = self.sliderAltura.value;
    /*UISwipeGestureRecognizer *sru = [[UISwipeGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(swipeAction:)];
    sru.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:sru];
    
    UISwipeGestureRecognizer *srd = [[UISwipeGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(swipeAction:)];
    srd.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:srd];
    
    
    [self.panRadio requireGestureRecognizerToFail:srd];
    [self.panRadio requireGestureRecognizerToFail:sru];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cambiaAltura:(UISlider *)sender {
    
    self.viewCirculo.altura = sender.value;
    [self.viewCirculo setNeedsDisplay];
}

- (IBAction)panRCambia:(UIPanGestureRecognizer *)sender {
    
            
        self.viewCirculo.radio +=[sender translationInView:sender.view].x;
        
        
        [sender setTranslation:CGPointZero inView:sender.view];
                
        
        [self.viewCirculo setNeedsDisplay];
    
    
}


@end
