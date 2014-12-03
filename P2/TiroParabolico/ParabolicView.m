//
//  ParabolicView.m
//  TiroParabolico
//
//  Created by g011 DIT UPM on 03/10/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "ParabolicView.h"
#import <math.h>

#define GRAVITY 9.80665
#define HMETERS 1000

@implementation ParabolicView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setSpeed:(float)speed{
    _speed=speed;
    [self setNeedsDisplay];
    
}



-(void)setAngle:(float)angle{
    _angle=angle;
    [self setNeedsDisplay];
}

// he añadido el metodo que nos permite cambiar la distancia.

-(void)setDistance:(float)distance{
    _distance=distance;
    [self setNeedsDisplay];
}



-(float) meters2X:(float)meters
{
    float w = self.bounds.size.width;
    return meters/HMETERS*w;
}

// he cambiado HMETERS por self.distance. lo que estamos haciendo ahora es extraño. HABLARLO

-(float) meters2Y:(float)meters
{
    float w = self.bounds.size.width;
    float h = self.bounds.size.height;
    return h-meters/HMETERS*w;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    float speedX0 = self.speed * cos(self.angle);
    float speedY0 = self.speed * sin(self.angle);
    float timeTotal = 2*speedY0/GRAVITY;
    
    float t=0;
    float x =[self meters2X:(speedX0 * t)];
    float y =[self meters2Y:(speedY0 * t - 0.5*GRAVITY*t*t)];
    
    float distanciaX= [self meters2X:(self.distance)];
    float distanciaY= [self meters2Y:(200)];
    float alturaAvion = [self meters2Y:(self.distance)+100];
    UIImage *img = [UIImage imageNamed:@"Diana.png"];
    UIImage *img2 = [UIImage imageNamed:@"Tank.png"];
    UIImage *img3 = [UIImage imageNamed:@"avion.png"];
    
    [img drawAtPoint:CGPointMake(distanciaX,distanciaY)];
    [img2 drawAtPoint:CGPointMake(0,distanciaY+20)];
    [img3 drawAtPoint:CGPointMake(200,alturaAvion)];
    
    UIBezierPath *path =[UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(x,y)];
    
    for(t=0;t<= timeTotal; t+=0.1){
        x =[self meters2X:(speedX0 * t)];
        y =[self meters2Y:(speedY0 * t - 0.5*GRAVITY*t*t)];
        float centroDiana = [self meters2X:(100)];
        float centroAvion = [self meters2X:(70)];
        float dianaX= (distanciaX+centroDiana-x);
        float dianaY= (distanciaY+centroDiana-y);
        float avionX= (200+centroAvion-x);
        float avionY= (alturaAvion+centroAvion-y);
        if(dianaX<0){
            dianaX=-dianaX;
        }
        if(dianaY<0){
            dianaY=-dianaY;
        }
        if(avionX<0){
            avionX=-avionX;
        }
        if(avionY<0){
            avionY=-avionY;
        }
        
        [path addLineToPoint:(CGPointMake(x,y))];
        if( dianaX <= 2){
            NSLog(@"restaX= %f",dianaX);
            NSLog(@"restaY= %f",dianaY);

            if( dianaY <= 2){
                                t=timeTotal;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"PERFECTO" message:[NSString stringWithFormat:@"Has dado en el centro de la diana"] delegate: self cancelButtonTitle:@"Volver a jugar" otherButtonTitles:nil];
                
                [alert show];
                
                
                
            }
        }
        
        if( avionX <= 1){
            
            
            if( avionY <= 3){
                t=timeTotal;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"PERFECTO" message:[NSString stringWithFormat:@"Has dado en el avion"] delegate: self cancelButtonTitle:@"Volver a jugar" otherButtonTitles:nil];
                
                [alert show];
                [self setSpeed: (self.speed-2)];
                //[self setAngle: (_angle-2)];
                //[self setDistance: (_distance-2)];
                
                
            }
        }
        
        }
    
    
    [[UIColor redColor] set];
    path.lineWidth=3;
    [path stroke];
}

@end

