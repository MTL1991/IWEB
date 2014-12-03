//
//  PokedeskModel.m
//  Pokedesk
//
//  Created by Santiago Pavón on 19/10/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "PokedeskModel.h"

#import "Race.h"
#import "Type.h"

@implementation PokedeskModel


- (instancetype) init
{
    if (self = [super init]) {
        
        // Cargar lista de propiedades:
		NSString * path = [[NSBundle mainBundle] pathForResource:@"pokemons"
                                                          ofType:@"plist"];
		NSDictionary * plist = [NSDictionary dictionaryWithContentsOfFile:path];
        NSDictionary * allNames = [plist valueForKey:@"nombres"];
		NSDictionary * allIcons = [plist valueForKey:@"iconos"];
		NSDictionary * allTypes = [plist valueForKey:@"tipos"];

        // Variables para calcular el futuro valor de la propiedades de esta clase.
        NSMutableArray *mutRaces = [NSMutableArray array];
        NSMutableArray *mutTypes = [NSMutableArray array];
        
        // Calcular valor de la propiedad self.races.
        [allNames enumerateKeysAndObjectsUsingBlock:^(NSString* raceCode,
                                                      NSString* raceName,
                                                      BOOL *stop) {
            NSNumber *code = [NSNumber numberWithInt:[raceCode intValue]];
            [mutRaces addObject:[[Race alloc] initWithCode:code
                                                      name:raceName
                                                      icon:allIcons[raceCode]]];
        }];

        // Calcular valor de la propiedad self.types.
        [allTypes enumerateKeysAndObjectsUsingBlock:^(NSString* typeName,
                                                      NSArray* typeRaceCodes,
                                                      BOOL *stop) {
            NSIndexSet *indexes = [mutRaces indexesOfObjectsPassingTest:^BOOL(Race* race,
                                                                              NSUInteger idx,
                                                                              BOOL *stop) {
                return [typeRaceCodes indexOfObject:race.code] != NSNotFound;
            }];
            NSArray * typeRaces = [mutRaces objectsAtIndexes:indexes];
            [mutTypes addObject:[[Type alloc] initWithName:typeName
                                                     races:typeRaces]];
        }];

        // Asignar valor a las propiedades
        _races = [mutRaces sortedArrayUsingComparator:^NSComparisonResult(Race* race1, Race* race2) {
            return [race1.code compare:race2.code];
        }];
        
        _types = [mutTypes sortedArrayUsingComparator:^NSComparisonResult(Type* type1, Type* type2) {
            return [type1.name compare:type2.name];
        }];
    }
    return self;
}


@end
