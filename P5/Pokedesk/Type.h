//
//  Type.h
//  Pokedesk
//
//  Created by Santiago Pavón on 19/10/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Clase para representar un tipo de pokemon.
 * A un tipo de pokemon pertenecen varias razas.
 */
@interface Type : NSObject

@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSArray* races;

/**
 * Inicializador de la clase Type.
 * @param name  Nombre del tipo.
 * @param races Todas las razas de este tipo.
 *              Es un array de objetos Race.
 */
- (instancetype) initWithName:(NSString*)name
                        races:(NSArray*)races;

@end
