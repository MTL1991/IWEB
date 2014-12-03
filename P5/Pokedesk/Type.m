//
//  Type.m
//  Pokedesk
//
//  Created by Santiago Pavón on 19/10/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "Type.h"

@implementation Type

- (instancetype) initWithName:(NSString*)name
                        races:(NSArray*)races
{
    if (self = [super init]) {
        _name = name;
        _races = races;
    }
    return self;
}

@end
