//
//  P3ViewController.m
//  Practica 3 - Media Naranja
//
//  Created by g011 DIT UPM on 17/10/13.
//  Copyright (c) 2013 g011 DIT UPM. All rights reserved.
//

#import "P3ViewController.h"
#import "SelectBirthdayViewController.h"
#import "PruebaResultadoViewController.h"

@interface P3ViewController ()

@property (nonatomic, strong) NSDate* birthday;
@property (nonatomic, strong) NSDate* deathday;
@property (nonatomic, strong) NSDate* filday;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *deathdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *fildayLabel;


@end

@implementation P3ViewController

-(void)setBirthday:(NSDate *)birthday
{
    _birthday = birthday;
    
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateStyle:NSDateFormatterLongStyle];
     NSLocale *esLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_ES"];
     [dateFormatter setLocale:esLocale];
     NSString * selected = [dateFormatter stringFromDate:birthday];
     self.birthdayLabel.text = selected;
    //self.birthdayLabel.text = [birthday description];
    
    
}
-(void)setDeathday:(NSDate *)deathday{
    _deathday = deathday;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateStyle:NSDateFormatterLongStyle];
     NSLocale *esLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_ES"];
     [dateFormatter setLocale:esLocale];
     NSString * selected = [dateFormatter stringFromDate:deathday];
     self.deathdayLabel.text = selected;
    
    
    //self.deathdayLabel.text = [deathday description];
    
}
-(void)setFilday:(NSDate *)filday{
    _filday = filday;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateStyle:NSDateFormatterLongStyle];
     NSLocale *esLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_ES"];
     [dateFormatter setLocale:esLocale];
     NSString * selected = [dateFormatter stringFromDate:filday];
     self.fildayLabel.text = selected;
    //self.fildayLabel.text = [filday description];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.birthday = [NSDate date];
    self.deathday = [NSDate date];
    self.filday = [NSDate date];
    
    
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"GetBirthday"]){
        
        SelectBirthdayViewController* sbvc = segue.destinationViewController;
        
        sbvc.dateSelected = self.birthday;
        sbvc.hola = @"¿CUANDO HAS NACIDO?";
        
    }
    if ( [segue.identifier isEqualToString:@"GetDeathday"]){
        
        SelectBirthdayViewController* sbvc = segue.destinationViewController;
        
        sbvc.dateSelected = self.deathday;
        sbvc.hola = @"¿CUANDO MORIRAS?";
    }
    if ( [segue.identifier isEqualToString:@"GetFilday"]){
        
        SelectBirthdayViewController* sbvc = segue.destinationViewController;
        
        sbvc.dateSelected = self.filday;
        sbvc.hola = @"¿CUANDO TE HAS ENAMORADO?";
    }
    if ([segue.identifier isEqualToString:@"Prueba"]){
        PruebaResultadoViewController* orvc= segue.destinationViewController;
        
        if([self.filday timeIntervalSinceDate: self.birthday]<0 || [self.deathday timeIntervalSinceDate: self.birthday]<0 || [self.deathday timeIntervalSinceDate: self.filday]<0){
            
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error de fechas" message:[NSString stringWithFormat:@"¿Seguro que esas fechas son correctas?"] delegate: self cancelButtonTitle:@"Volver" otherButtonTitles:nil];
            
            [alert show];
        }else{
            orvc.dateDeathday = self.deathday;
            orvc.dateBirthday = self.birthday;
            orvc.dateFilday = self.filday;
            
        }
        
        
        
    }
}

-(IBAction)updateBirthday:(UIStoryboardSegue* )segue
{
    if([segue.identifier isEqualToString:@"NewDate"]){
        
        SelectBirthdayViewController* sbvc = segue.sourceViewController;
        if([sbvc.hola isEqualToString:@"¿CUANDO HAS NACIDO?"]){
            self.birthday = sbvc.dateSelected;
        }
        if([sbvc.hola isEqualToString:@"¿CUANDO MORIRAS?"]){
            self.deathday = sbvc.dateSelected;
        }
        if([sbvc.hola isEqualToString:@"¿CUANDO TE HAS ENAMORADO?"]){
            self.filday = sbvc.dateSelected;
        }
    }
}

-(IBAction)cancel:(UIStoryboardSegue* )segue
{
    
    
}



@end
