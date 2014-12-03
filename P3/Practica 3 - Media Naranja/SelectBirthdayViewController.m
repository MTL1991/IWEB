//
//  SelectBirthdayViewController.m
//  Practica 3 - Media Naranja
//
//  Created by g011 DIT UPM on 17/10/13.
//  Copyright (c) 2013 g011 DIT UPM. All rights reserved.
//

#import "SelectBirthdayViewController.h"

@interface SelectBirthdayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (weak, nonatomic) IBOutlet UIDatePicker *birthdayPicker;

@end

@implementation SelectBirthdayViewController

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
    
    self.questionLabel.text = self.hola;
    
    self.birthdayPicker.date = self.dateSelected;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"NewDate"]){
        self.dateSelected = self.birthdayPicker.date;
        
        
    }else if([segue.identifier isEqualToString:@"NewDate"]){
        //Nada
    }
    
}

@end
