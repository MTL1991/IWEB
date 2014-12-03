//
//  NuevosPokemonsTableViewController.h
//  Pokedesk
//
//  Created by Manuel on 11/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokedeskModel.h"
#import "Type.h"
@interface NuevosPokemonsTableViewController : UITableViewController
@property (nonatomic,strong) Type* type;
@end
