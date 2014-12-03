//
//  GHPView.m
//  Granja
//
//  Created by Santiago Pavón on 14/12/12.
//  Modified by Manuel Toro Legaz on 6/11/10.
//  Copyright (c) 2012 UPM. All rights reserved.
//

#import "GHPView.h"
#import "ViewController.h"


enum GHPState {
	GHP_I_AM_HEN,
	GHP_I_AM_EGG,
	GHP_I_AM_CHICKEN,
	GHP_I_AM_FRIED,
	GHP_I_AM_ROAST,
    GHP_I_AM_BREAK
};

// Propiedades privadas
@interface GHPView ()

@property (nonatomic) enum GHPState ghpState;

@property (nonatomic) CGFloat scale;
@property (nonatomic) CGFloat rotation;
@property (nonatomic) CGFloat translationX;
@property (nonatomic) CGFloat translationY;

@end

@implementation GHPView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        self.scale = 1;
        self.rotation = 0;
        self.translationX = 0;
        self.translationY = 0;
        
        // Resize mask
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleRightMargin |
                                UIViewAutoresizingFlexibleTopMargin |
                                UIViewAutoresizingFlexibleBottomMargin;
        
        // Necesito enterarme de los eventos.
        [self setUserInteractionEnabled:YES];
        
        self.ghpState = GHP_I_AM_HEN; // Imagen inicial
        
		
		
        // Crea Tap dobke para ir de huevo a huevo roto
        UITapGestureRecognizer *tapRec2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(processTap2:)];
        [tapRec2 setNumberOfTapsRequired:2];
        [self addGestureRecognizer:tapRec2];
        
        // Crea reconocedor de Tap para ir de gallina a huevo, a pollo, y a gallina
		UITapGestureRecognizer *tapRec = [[UITapGestureRecognizer alloc]
										  initWithTarget:self
										  action:@selector(processTap:)];
		//[tapRec setNumberOfTapsRequired:1];
        [tapRec requireGestureRecognizerToFail:tapRec2];
		[self addGestureRecognizer:tapRec];
        
		// Creo reconocedor de Long Press para freir huevo
		UILongPressGestureRecognizer *lpRec = [[UILongPressGestureRecognizer alloc]
											   initWithTarget:self
											   action:@selector(processLongPress:)];
		[self addGestureRecognizer:lpRec];
		
		// Crea reconocedor de Pan para mover imagen view
		UIPanGestureRecognizer *panRec = [[UIPanGestureRecognizer alloc]
										  initWithTarget:self
										  action:@selector(processPan:)];
		[self addGestureRecognizer:panRec];
		
		// Crea reconocedor de Pinch para escalar imagen view
		UIPinchGestureRecognizer *pinchRec = [[UIPinchGestureRecognizer alloc]
											  initWithTarget:self
											  action:@selector(processPinch:)];
		[self addGestureRecognizer:pinchRec];
        
    	// Crea reconocedor de Rotation para girar imagen view
		UIRotationGestureRecognizer *rotationRec = [[UIRotationGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(processRotation:)];
		[self addGestureRecognizer:rotationRec];
        
    }
    return self;
}


- (void) setGhpState:(enum GHPState)ghpState {  // Redefino el setter
    
	_ghpState = ghpState;
    ViewController *vc = [self viewController];
	switch (ghpState) {
            
		case GHP_I_AM_HEN:
			self.image = [UIImage imageNamed:@"gallina.png"];
            vc.texto.text = @"gallina";
			break;
		case GHP_I_AM_EGG:
			self.image = [UIImage imageNamed:@"huevo.png"];
			break;
		case GHP_I_AM_CHICKEN:
			self.image = [UIImage imageNamed:@"pollo.png"];
			break;
		case GHP_I_AM_FRIED:
			self.image = [UIImage imageNamed:@"frito.png"];
			break;
        case GHP_I_AM_ROAST:
			self.image = [UIImage imageNamed:@"asado.png"];
			break;
        case GHP_I_AM_BREAK:
            self.image = [UIImage imageNamed:@"roto.png"];
    }
    
    self.bounds = CGRectMake(0,
                             0,
                             self.image.size.width,
                             self.image.size.height);
    [self updateAffineTransforms];
}


-(void)processTap2:(UITapGestureRecognizer *)sender{
    ViewController *vc = [self viewController];
    if(self.ghpState==GHP_I_AM_EGG){
        self.ghpState = GHP_I_AM_BREAK;
        vc.texto.text = @"huevo roto";
    }
}
-(void)processTap:(UITapGestureRecognizer *)sender {
	ViewController *vc = [self viewController];
	switch (self.ghpState) {
            
		case GHP_I_AM_HEN:
			self.ghpState = GHP_I_AM_EGG;
            
            vc.texto.text = @"huevo";
			break;
			
		case GHP_I_AM_EGG:
			self.ghpState = GHP_I_AM_CHICKEN;
            vc.texto.text = @"pollo";
			break;
			
		case GHP_I_AM_CHICKEN:
			self.ghpState = GHP_I_AM_HEN;
            vc.texto.text = @"gallina";
			break;
            
		case GHP_I_AM_FRIED:
            vc.texto.text = @"huevo frito";
			break;
            
		case GHP_I_AM_ROAST:
            vc.texto.text = @"pollo asado";
			break;
        case GHP_I_AM_BREAK:
            break;
    }
}

- (ViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        
        if ([nextResponder isKindOfClass:[ViewController class]])
        {
            return (ViewController*)nextResponder;
        }
    }
    
    return nil;
}


-(void)processLongPress:(UILongPressGestureRecognizer *)sender {
	
    // NSLog(@"LP state=%i img=%i",sender.state, self.ghpState);
    ViewController *vc = [self viewController];
    if (sender.state != UIGestureRecognizerStateBegan) return;
    
	switch (self.ghpState) {
        case GHP_I_AM_HEN: { // Llaves necesarias en ARC para indicar ambito
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionTransitionFlipFromLeft
                             animations:^{
                                 self.ghpState = GHP_I_AM_ROAST;
                             }
                             completion:nil];
            vc.texto.text = @"pollo asado";
			break;
        }
        case GHP_I_AM_EGG: { // Llaves necesarias en ARC para indicar ambito
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionTransitionFlipFromLeft
                             animations:^{
                                 self.ghpState = GHP_I_AM_FRIED;
                             }
                             completion:nil];
            vc.texto.text = @"huevo frito";
            break;
        }
		case GHP_I_AM_CHICKEN:
            break;
		case GHP_I_AM_FRIED:
			break;
		case GHP_I_AM_ROAST:
			break;
        case GHP_I_AM_BREAK:
            break;
	}
}





- (void)processPinch:(UIPinchGestureRecognizer *)sender
{
	CGFloat factor = sender.scale;
    
  //  NSLog(@"Diff scale = %f  My scale = %f",factor, self.scale);
    
    self.scale *= factor ;
    sender.scale = 1;
    
    [self updateAffineTransforms];
}


- (void)processRotation:(UIRotationGestureRecognizer *)sender
{
	CGFloat angle = sender.rotation;
    
 //   NSLog(@"Diff rotation = %f  My rotation = %f",angle, self.rotation);
    
    self.rotation += angle;
    sender.rotation = 0;
    
    [self updateAffineTransforms];
}


- (void)processPan:(UIPanGestureRecognizer *)sender
{
    CGPoint pos = [sender translationInView:[sender.view superview]];
    
  //  NSLog(@"Diff translation (x=%f y=%f)",pos.x, pos.y);
    
	self.translationX += pos.x;
    self.translationY += pos.y;
    
    [sender setTranslation:CGPointZero inView:sender.view];
    
    [self updateAffineTransforms];
}


- (void) updateAffineTransforms
{
	CGAffineTransform t1 = CGAffineTransformMakeTranslation(self.translationX, self.translationY);
    CGAffineTransform t2 = CGAffineTransformMakeRotation(self.rotation);
	CGAffineTransform t3 = CGAffineTransformMakeScale(self.scale, self.scale);
    
	self.transform = CGAffineTransformConcat(t3,CGAffineTransformConcat(t2,t1));
}


@end
