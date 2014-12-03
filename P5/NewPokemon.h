//
//  NewPokemon.h
//  Pokedesk
//
//  Created by Manuel on 11/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PokedeskModel.h"
#import "Race.h"

@interface NewPokemon : NSObject

@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) Race* race;

-(instancetype) initWithName:(NSString*) name
                        race:(Race*) race;


@end

