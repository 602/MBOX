//
//  ZZTextField.m
//  TalentService
//
//  Created by zhizhen on 15/7/29.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "ZZTextField.h"

@implementation ZZTextField
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

- (BOOL)isRegex:(NSString*)candidate
{//(“^[A-Za-z0-9]+$”) ;
 //@"^[0-9]+$"  纯数字  只能输入由数字和26个英文字母组成的字符串：(“^[A-Za-z0-9]+$”) ;
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regexStr];
    return [emailTest evaluateWithObject:candidate];
}


- (BOOL)isPhoneNumber{

    NSString *telRegex = @"^1[34578]\\d{9}$";
    NSPredicate *prediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [prediate evaluateWithObject:self.text];
}
- (BOOL)isSecutityNumber{
    NSString *telRegex = @"[0-9]{6}$";
    NSPredicate *prediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [prediate evaluateWithObject:self.text];


}


- (BOOL)isPassWordWithMin:(NSUInteger)min max:(NSUInteger)max{
    NSString *telRegex = [NSString  stringWithFormat:@"[A-Za-z0-9]{%ld,%ld}$", min,max];
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",telRegex];
    return [emailTest evaluateWithObject:self.text];
}


-(void)addLeftViewImageString:(NSString *)imageString{
    UIImageView* phoneIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    phoneIV.image= [UIImage imageNamed:imageString];
    phoneIV.contentMode = UIViewContentModeCenter;
    [self setLeftView:phoneIV];
    self.leftViewMode = UITextFieldViewModeAlways;
}

-(void)addLeftViewLabel:(NSString *)labelString{
//    CGSize labelSize = [labelString textSizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(1000, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.width = 50;
    phoneLabel.height = 30;
    phoneLabel.font = [UIFont systemFontOfSize:15];
    phoneLabel.textColor = [UIColor lightGrayColor];
    phoneLabel.text = labelString;
    [self setLeftView:phoneLabel];
    self.leftViewMode = UITextFieldViewModeAlways;
}
@end
