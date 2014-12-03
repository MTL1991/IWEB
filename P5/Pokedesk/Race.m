//
//  Race.m
//  Pokedesk
//
//  Created by Santiago Pavón on 19/10/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "Race.h"

@implementation Race

- (instancetype) initWithCode:(NSNumber*)code
                         name:(NSString*)name
                         icon:(NSString*)icon
{
    if (self = [super init]) {
        _code = code;
        _name = name;
        _icon = icon;
    }
    return self;
}


@end
