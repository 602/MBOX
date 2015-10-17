//
//  NewPlayerCell.h
//  myProject
//
//  Created by 顾欢欢 on 15/8/16.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#define newCellIdentifier @"newplayerCellIdentifier"
@interface NewPlayerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;

@end
