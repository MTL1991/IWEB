//
//  Tweet.m
//  Busca Pios
//
//  Created by Santiago Pavón on 16/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet


- (instancetype) initWithText:(NSString *) text
                     username:(NSString *) username
                     imageUrl:(NSString *) imageUrl
{
	if (self = [super init]) {
		self.text = text;
		self.username = username;
		self.imageUrl = imageUrl;
	}
	return self;
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"[ %@ | %@ | %@ ]",self.username, self.text, self.imageUrl];
}

@end
