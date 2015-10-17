//
//  HomeCell.m
//  myProject
//
//  Created by charles on 15/7/30.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {
    // Initialization code
}
#pragma mark - Getters and Setters

//Setters
- (void)setModel:(MenuCellModel *)model {
    self.headIV.image = [UIImage imageNamed:model.img];
    self.headLabel.text = model.title;
    self.contantLabel.text = model.subTitle;
}

//Getters
- (UIImageView *)headIV {
    if (!_headIV) {
        _headIV = [[UIImageView alloc]init];
    }
    return _headIV;
}
- (UILabel *)headLabel {
    if (!_headLabel) {
        _headLabel = [[UILabel alloc]init];
    }
    return _headLabel;
}
- (UILabel *)contantLabel {
    if (!_contantLabel) {
        _contantLabel = [[UILabel alloc]init];
    }
    return _contantLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
