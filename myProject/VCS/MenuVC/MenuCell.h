//
//  MenuCell.h
//  myProject
//
//  Created by Apple on 15/5/31.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#define menuCellIdentifier  @"menuCellIdentifier"
@interface MenuCell : UITableViewCell
@property (strong, nonatomic) MenuCellModel *model;

@property (strong, nonatomic) UIImageView *headerImage;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
+ (float) cellHeight;
@end
