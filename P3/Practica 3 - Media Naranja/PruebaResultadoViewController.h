//
//  PruebaResultadoViewController.h
//  Practica 3 - Media Naranja
//
//  Created by Manuel on 20/10/13.
//  Copyright (c) 2013 g011 DIT UPM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PruebaResultadoViewController : UIViewController{
    
    IBOutlet UIImageView *imagen1; //cuarto
    IBOutlet UIImageView *imagen2; //entera
    IBOutlet UIImageView *imagen3; //trescuartos
    IBOutlet UIImageView *imagen4; //media
    IBOutlet UIImageView *imagen5;
    
}
@property (nonatomic, strong) NSDate* dateDeathday;
@property (nonatomic, strong) NSDate* dateBirthday;
@property (nonatomic, strong) NSDate* dateFilday;
@property (nonatomic, strong) UIImageView* imagen1;
@property (nonatomic, strong) UIImageView* imagen2;
@property (nonatomic, strong) UIImageView* imagen3;
@property (nonatomic, strong) UIImageView* imagen4;
@property (nonatomic, strong) UIImageView* imagen5;




@end
