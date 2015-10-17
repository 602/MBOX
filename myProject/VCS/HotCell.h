//
//  HotCell.h
//  myProject
//
//  Created by Charles_Wl on 15/8/10.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#define hotCellIdentifier  @"hotCellIdentifier"

@class HotCell;
@protocol HotCellDelegate <NSObject>

- (void)didClickOnLeftbutton:(UIButton *)btn;
- (void)hotCell:(HotCell *)cell didClickOnLeftbutton:(UIButton *)btn;
@end

@interface HotCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (assign, nonatomic) id<HotCellDelegate>delegate;
@end
