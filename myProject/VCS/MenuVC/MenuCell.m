//
//  MenuCell.m
//  myProject
//
//  Created by Apple on 15/5/31.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "MenuCell.h"

#define kHeaderImageWidth 50

@implementation MenuCell

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)layoutSubviews {
    //使用masonry布局
    
    //头像
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(PIXEL_8);
        make.left.equalTo(self.contentView.mas_left).offset(PIXEL_8);
        make.width.mas_equalTo(kHeaderImageWidth);
        make.height.mas_equalTo(kHeaderImageWidth);
    }];
    //标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImage.mas_top);
        make.left.equalTo(self.headerImage.mas_right).offset(PIXEL_8);
        make.right.equalTo(self.contentView.mas_right).offset(-PIXEL_8);
        make.height.mas_equalTo(kHeaderImageWidth/2);
    }];
    //副标题
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.equalTo(self.headerImage.mas_right).offset(PIXEL_8);
        make.right.equalTo(self.contentView.mas_right).offset(-PIXEL_8);
        make.height.mas_equalTo(kHeaderImageWidth/2);
    }];
    
}

#pragma mark - Private method
- (void)initUI {
    [self.contentView addSubview:self.headerImage];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
}
+ (float)cellHeight {

    return 2*PIXEL_8+kHeaderImageWidth;
}
#pragma mark - Getters and Setters

//Setters
- (void)setModel:(MenuCellModel *)model {
    self.headerImage.image = [UIImage imageNamed:model.img];
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.subTitle;
}

//Getters
- (UIImageView *)headerImage {
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc]init];
    }
    return _headerImage;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc]init];
    }
    return _subTitleLabel;
}
@end
