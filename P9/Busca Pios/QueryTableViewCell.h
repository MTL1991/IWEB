//
//  QueryTableViewCell.h
//  Busca Pios
//
//  Created by Santiago Pavón on 16/11/13.
//  Copyright (c) 2013 UPM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

@end
