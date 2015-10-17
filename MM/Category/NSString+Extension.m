//
//  NSString+Extension.m
//  TalentService
//
//  Created by zhizhen on 15/7/27.
//  Copyright (c) 2015年 zhizhen. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
//移除内容前后的空格和回车
-(NSString*)removeWhitespaceAndNewlineCharacter;{
    return [self   stringByTrimmingCharactersInSet:[NSCharacterSet  whitespaceAndNewlineCharacterSet]];
}

//截取一定长度的字符串
-(NSString*)subStringFromTitleOrcontentWithLength:(NSUInteger)wordCount{
    
    NSString*  text = self;
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSUInteger  subWordCount = wordCount/2;
    NSData* da = [text dataUsingEncoding:enc];
    if (da.length>wordCount) {
        NSString*  str = nil;
        for (NSUInteger i = subWordCount; i<text.length; i++) {
            
            if ([[text substringToIndex:i] dataUsingEncoding:enc].length >= wordCount) {
                
                str = [text substringToIndex:i];
                
                break;
            }
        }
        return str;
    }else{
        return text;
    }
}

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    if(font == nil){
        font = [UIFont  systemFontOfSize:16];
    }
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize  backSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    return CGSizeMake(ceil(backSize.width)+1, ceil(backSize.height));
}
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)size{
    if(font == nil){
        font = [UIFont  systemFontOfSize:16];
    }
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    
    CGSize  backSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
    return CGSizeMake(ceil(backSize.width)+1, ceil(backSize.height));
}
-(BOOL) isOlderVersionThan:(NSString*)otherVersion
{
    return ([self compare:otherVersion options:NSNumericSearch] == NSOrderedAscending);
}
-(BOOL) isNewerVersionThan:(NSString*)otherVersion
{
    return ([self compare:otherVersion options:NSNumericSearch] == NSOrderedDescending);
}



-(NSUInteger) unicodeLength
{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
//    NSUInteger unicodeLength = asciiLength / 2;
//    if(asciiLength % 2) {
//        unicodeLength++;
//    }
    return asciiLength;
}

- (BOOL)isCorrectPhoneNumber{
    NSString *telRegex = @"^1[34578]\\d{9}$";
    NSPredicate *prediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [prediate evaluateWithObject:self];
}
- (BOOL)isSecutityNumber{
    NSString *telRegex = @"[0-9]{6}$";
    NSPredicate *prediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [prediate evaluateWithObject:self];
}


- (BOOL)isPassWordWithMin:(NSUInteger)min max:(NSUInteger)max{
    NSString *telRegex = [NSString  stringWithFormat:@"[A-Za-z0-9]{%ld,%ld}$", min,max];
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",telRegex];
    return [emailTest evaluateWithObject:self];
}

- (NSMutableAttributedString *)getReplyAttributedStringFont:(UIFont *)font  color:(UIColor *)color{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString   alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle  alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
 
    NSRange range = NSMakeRange(0,attributedString.length);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    //字体大小
    if (font) {
        [attributedString  addAttributes:@{NSFontAttributeName:font} range:range];
    }
    if (color) {
        [attributedString  addAttributes:@{NSForegroundColorAttributeName :color} range:range];
    }
    //字间距
    long number = 1;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedString addAttribute:NSKernAttributeName value:(__bridge id)num range:range];
    CFRelease(num);
    
    return attributedString;
}
/**得到拼接字符串且编码的路径str*/
- (NSString *)getUrlUseEncodAppend:(NSString *)appstring{
    return  [[self stringByAppendingString:appstring] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
