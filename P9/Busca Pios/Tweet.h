//
//  Tweet.h
//  Busca Pios
//
//  Created by Santiago Pavón on 16/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (strong) NSString *imageUrl;
@property (strong) NSString *username;
@property (strong) NSString *text;

-(id)initWithText:(NSString *)text
         username:(NSString *)username
         imageUrl:(NSString *)imageUrl;

@end
