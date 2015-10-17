//
//  ExChangeCell.h
//  myProject
//
//  Created by Charles_Wl on 15/8/9.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#define exChangeCellIdentifier  @"exChangeCellIdentifier"
@interface ExChangeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headIV;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *middleLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@end
