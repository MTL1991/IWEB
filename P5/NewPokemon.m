//
//  NewPokemon.m
//  Pokedesk
//
//  Created by Manuel on 11/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//


#import "NewPokemon.h"
#import "PokedeskModel.h"
#import "Race.h"

@interface NewPokemon () <UISearchBarDelegate, UISearchDisplayDelegate>
@property (strong, nonatomic)PokedeskModel *pokedeskModel;

@end

@implementation NewPokemon



-(instancetype) initWithName:(NSString*) name
                        race:(Race*) race
{
    if(self = [super init]){
        _name = name;
        _race = race;
        
    }
    return self;
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"(%@ [%@]",self.name,self.race.name];
}

@end
