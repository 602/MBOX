//
//  WTLabel.m
//  core_animation
//
//  Created by 王涛 on 15/4/22.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTLabel.h"
@implementation WTLabel
/**
 * set方法
 */
-(void)setTitle:(NSString *)title{

    self.titleLabel.text = title;

}
-(void)setSubTitle:(NSString *)subTitle{

    self.subTitleLabel.text = subTitle;
}

-(void)setButtonTitle:(NSString *)buttonTitle{

    [self.btn setTitle:buttonTitle forState:UIControlStateNormal];
}
- (void)setImg:(NSString *)img {
    if (!img ||
        ![img length]) {
        return;
    }
    
    _img = img;
    UIImage *image = [UIImage imageNamed:img];
    [_iconImg setImage:image];
}
-(id)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit:self.frame];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title andSubTitle:(NSString *)subTitle andButtonTitle:(NSString *)buttonTitle andIcon:(NSString *)img{

    if (self = [super initWithFrame:frame]) {
        
        [self commonInit:frame ];
        [self setTitle:title];
        [self setSubTitle:subTitle];
        [self setButtonTitle:buttonTitle];
        [self setImg:img];
        
    }
    return self;
}

- (void)commonInit:(CGRect)frame{
    
    self.backgroundColor = [UIColor clearColor];
    //icon
    _iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(PIXEL_16, 0, kDefaultHeadImageWidth, kDefaultHeadImageHeight)];
    //labels
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconImg.x+_iconImg.width+PIXEL_4, 0, kLabel_Width, kDefaultHeadImageHeight/2)];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
    
    _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.x, _titleLabel.frame.size.height, _titleLabel.frame.size.width, kDefaultHeadImageHeight/2)];
    _subTitleLabel.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
    _subTitleLabel.numberOfLines = 0;
    _subTitleLabel.font = [UIFont systemFontOfSize:14];
    //_subTitleLabel.backgroundColor = [UIColor grayColor];
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(0, _subTitleLabel.y+_subTitleLabel.height+20, _titleLabel.width-kDefaultHeadImageWidth-PIXEL_8, kDefaultButtonHeight)];
    [_btn addTarget:self action:@selector(didClickOnBtn:) forControlEvents:UIControlEventTouchUpInside];
    _btn.backgroundColor = [UIColor colorWithRed:(57.0f / 255.0f) green:(106.0f / 255.0f) blue:(180.0f / 255.0f) alpha:1.0f];
    _btn.titleLabel.font = [UIFont systemFontOfSize:20];
    _btn.layer.cornerRadius = 3.f;
    _btn.layer.masksToBounds = YES;
    
    [self addSubview:_iconImg];
    [self addSubview:_titleLabel];
    [self addSubview:_subTitleLabel];
    [self addSubview:_btn];

}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat y = kDefaultHeadImageWidth/2;
    
    self.titleLabel.width = self.width-kDefaultHeadImageWidth-PIXEL_4;
    self.subTitleLabel.width = self.titleLabel.width;
    CGSize detailLabelSize = [self getSubTitleLabelHeight];
    float height = detailLabelSize.height;
    _subTitleLabel.height = detailLabelSize.height;
    y+=height+20;

    _btn.centerX = self.width/2;
    self.btn.y = y;
    
    
}
#pragma mark - Utility
- (CGSize)getSubTitleLabelHeight{

    CGSize titleSize = [_subTitleLabel.text boundingRectWithSize:CGSizeMake(kLabel_Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    return titleSize;
}
- (CGSize)autoSizeWith:(UILabel *)label {
    
    if (!label.text) {
    
        CGSize size = CGSizeMake(0, 0);
        return size;
    }

    NSRange allRange = [label.text rangeOfString:label.text];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:14]
                    range:allRange];
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect Size = [attrStr boundingRectWithSize:CGSizeMake([UIScreen mainScreen].applicationFrame.size.width-80-40, 100)
                                        options:options
                                        context:nil];
    CGSize labelSize;
    labelSize.width = Size.size.width;
    labelSize.height = Size.size.height;
    return labelSize;

}

- (void)didClickOnBtn:(UIButton *)btn{

    [self.delegate didClickOnBtn];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
