//
//  PruebaDrawView.m
//  Prueba Draw
//
//  Created by Manuel on 01/12/13.
//  Copyright (c) 2013 Manuel. All rights reserved.
//

#import "PruebaDrawView.h"

@implementation PruebaDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(100, _altura) radius: _radio startAngle:0 endAngle:M_PI*2 clockwise: TRUE];
    [path closePath];
    [[UIColor magentaColor] setStroke];
    [[UIColor blueColor] setFill];
    [path fill];
    path.lineWidth= 4;
    [path stroke];
    
}


@end
