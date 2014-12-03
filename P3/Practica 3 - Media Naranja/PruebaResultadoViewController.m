//
//  PruebaResultadoViewController.m
//  Practica 3 - Media Naranja
//
//  Created by Manuel on 20/10/13.
//  Copyright (c) 2013 g011 DIT UPM. All rights reserved.
//

#import "PruebaResultadoViewController.h"

@interface PruebaResultadoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *result;
@property (weak, nonatomic) IBOutlet UIButton *prob;







@end

@implementation PruebaResultadoViewController
@synthesize  imagen1, imagen2,imagen3,imagen4,imagen5;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

        NSTimeInterval diferenciaVida = [self.dateDeathday timeIntervalSinceDate: self.dateBirthday];
        NSTimeInterval diferenciaAmor = [self.dateFilday timeIntervalSinceDate: self.dateBirthday ];
        self.imagen1.hidden = YES;
        self.imagen2.hidden = YES;
        self.imagen3.hidden = YES;
        self.imagen4.hidden = YES;
        self.imagen5.hidden = YES;
        double dif = diferenciaAmor/diferenciaVida;
        
        NSString *porcentaje= [NSString stringWithFormat:@"%g", (1-dif)*100];
        if((1-dif )> 0.75){
            self.imagen2.hidden = NO;
            /*self.imagen2.hidden = YES;
             self.imagen3.hidden = YES;
             self.imagen4.hidden = YES;
             */
        }else if ((1-dif ) > 0.5){
            self.imagen3.hidden = NO;
            /*self.imagen1.hidden = YES;
             self.imagen2.hidden = YES;
             self.imagen4.hidden = YES;
             */
        }else if ((1-dif ) > 0.25){
            /*self.imagen1.hidden = YES;
             self.imagen2.hidden = YES;
             self.imagen3.hidden = NO;*/
            self.imagen4.hidden = NO;
        }else if ((1-dif ) > 0){
            self.imagen1.hidden = NO;
            /*   self.imagen2.hidden = YES;
             self.imagen3.hidden = YES;
             self.imagen4.hidden = NO;
             */
        }else{
            self.imagen5.hidden = NO;
        }
        self.result.text =  [NSString stringWithFormat:@"%s%@%s","Esta persona es tu ",porcentaje,"% de naranja"];
        
    }



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
