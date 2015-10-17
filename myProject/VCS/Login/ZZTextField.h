//
//  ZZTextField.h
//  TalentService
//
//  Created by zhizhen on 15/7/29.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZTextField : UITextField

/**
 *  最多的输入内容，字符
 */
@property(nonatomic) NSUInteger  textContentLength;

/**
 *  限制输入内容的正则表达式
 @"^[0-9]+$"  纯数字
 只能输入由数字和26个英文字母加下划线组成的字符串：(“^[A-Za-z0-9_]+$”) ;
 */
@property (nonatomic, strong) NSString *regexStr;



/**
 *  是否是密码  密码标准为：数字和26个英文字母加下划线
 *
 *  @param min 密码最短长度（包含）
 *  @param max 密码最长长度（包含）
 *
 *  @return 格式且长度也符合标准，
 */
- (BOOL)isPassWordWithMin:(NSUInteger )min max:(NSUInteger )max;

/**
 *  是否是电话号码:1 3\4\5\7\8
 *
 *  @return <#return value description#>
 */
- (BOOL)isPhoneNumber;

/**
 *  设置textView的leftView
 */
-(void)addLeftViewImageString:(NSString*)imageString;

-(void)addLeftViewLabel:(NSString *)labelString;
@end
