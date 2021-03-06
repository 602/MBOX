//
//  infoCell.h
//  myProject
//
//  Created by Charles_Wl on 15/8/17.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#define infoCellIdentifier  @"infoCellIdentifier"

@class infoCell;
@protocol infoCellDelegate <NSObject>

- (void)textFieldDidChange:(infoCell *)cell;

@end

@interface infoCell : UITableViewCell<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *headLabel;
@property (strong, nonatomic) IBOutlet UITextField *informationTF;
@property (nonatomic) id<infoCellDelegate>delegate;
@end
