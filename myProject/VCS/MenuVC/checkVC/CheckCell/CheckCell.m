//
//  CheckCell.m
//  com.icetang.www
//
//  Created by Charles_Wl on 15/9/22.
//  Copyright © 2015年 王涛. All rights reserved.
//

#import "CheckCell.h"

@interface CheckCell()
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation CheckCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
