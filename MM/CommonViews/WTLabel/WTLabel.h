//
//  WTLabel.h
//  core_animation
//
//  Created by 王涛 on 15/4/22.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

#define kDefaultHeadImageWidth 55
#define kDefaultHeadImageHeight 55
#define kDefaultButtonHeight 40
#define kGap 30
#define kLabel_Width [UIScreen mainScreen].applicationFrame.size.width-kDefaultHeadImageWidth-2*kGap-PIXEL_12

@protocol WTLabelDelegate <NSObject>

- (void)didClickOnBtn;

@end

@interface WTLabel : UIView
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subTitle;
@property (nonatomic, copy)NSString *buttonTitle;
@property (nonatomic, copy)NSString *img;

@property (nonatomic, strong) UILabel * titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UIButton *btn;

@property (weak, nonatomic) id<WTLabelDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title andSubTitle:(NSString *)subTitle andButtonTitle:(NSString *)buttonTitle andIcon:(NSString *)img;
@end
