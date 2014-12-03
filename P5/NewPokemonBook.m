//
//  NewPokemonBook.m
//  Pokedesk
//
//  Created by Manuel on 11/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "NewPokemonBook.h"
#import "NewPokemon.h"

@implementation NewPokemonBook

-(NSMutableArray*) NewPokemon
{
    if(! _NewPokemon){
        _NewPokemon = [NSMutableArray array];
        NSNumber  * code1 = [[NSNumber alloc] initWithInt:1];
        [_NewPokemon addObjectsFromArray:
         @[[[NewPokemon alloc] initWithName:@"Prueba"
                                       race: [[Race alloc] initWithCode: code1
                                                                   name:@"Prueba"
                                                                   icon:@"009.gif"]],
           ]];
    }
    return _NewPokemon;
}

@end

