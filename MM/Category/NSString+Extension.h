//
//  NSString+Extension.h
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  移除字符串前后的回车和空格
 *
 *  @return 返回格式化后的字符串
 */
-(NSString*)removeWhitespaceAndNewlineCharacter;
/**
 *  根据字数截取字符串
 *
 *  @param wordCount 需要的字符数
 *
 *  @return 返回截取后的字符串
 */
- (NSString*)subStringFromTitleOrcontentWithLength:(NSUInteger)wordCount;

/**
 *  计算字符串高度
 *
 *  @param font 字体
 *  @param maxW 最大宽度
 *
 *  @return 计算后的size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

/**
 *  老版本比较
 *
 *  @param otherVersion 比较的版本号
 *
 *  @return yes：比otherVersion老
 */
- (BOOL) isOlderVersionThan:(NSString*)otherVersion;

/**
 *  新版本比较
 *
 *  @param otherVersion 比较的版本号
 *
 *  @return yes：比otherVersion新
 */
- (BOOL)isNewerVersionThan:(NSString*)otherVersion;


/**
 *  计算字符长度，一个汉字为两个字符，两个英文字母为一个字符
 *
 *  @return <#return value description#>
 */
- (NSUInteger)unicodeLength;


/**
 *  计算字符串高度
 *
 *  @param font 字体
 *  @param 最大size
 *
 *  @return 计算后的size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)size;


/**
 *  是否是电话号码
 *
 *  @return yes是
 */
- (BOOL)isCorrectPhoneNumber;

/**
 *  是否是验证码
 *
 *  @return yes是
 */
- (BOOL)isSecutityNumber;

/**
 *  符合密码的长度
 *
 *  @param min 密码最小长度
 *  @param max 密码最大长度
 *  英文字母大小写、数字、下划线可以为密码组成部分
 *  @return 符合规则返回YES
 */
- (BOOL)isPassWordWithMin:(NSUInteger)min max:(NSUInteger)max;


/**
 *  得到回复的自定义字符串
 *
 *  @param font  字体
 *  @param color 颜色
 行、字、段间距调用统一定义的
 */
- (NSMutableAttributedString *)getReplyAttributedStringFont:(UIFont *)font  color:(UIColor *)color;

/**得到拼接字符串且编码的路径str*/
- (NSString *)getUrlUseEncodAppend:(NSString *)appstring;

@end
