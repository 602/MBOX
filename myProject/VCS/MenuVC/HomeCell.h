//
//  HomeCell.h
//  myProject
//
//  Created by charles on 15/7/30.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#define menuCellIdentifier  @"menuCellIdentifier"
@interface HomeCell : UITableViewCell
@property (strong, nonatomic) MenuCellModel *model;
@property (strong, nonatomic) IBOutlet UIImageView *headIV;
@property (strong, nonatomic) IBOutlet UILabel *headLabel;
@property (strong, nonatomic) IBOutlet UILabel *contantLabel;

@end
