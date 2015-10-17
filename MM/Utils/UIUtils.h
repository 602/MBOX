//
//  UIUtils.h
//  QQing
//
//  Created by 王涛 on 3/1/15.
//
//

#import <Foundation/Foundation.h>

@interface UIUtils : NSObject
/**
 * 这里都是和UI有关的工具设置
 */
/**
 * 设置视图风格，阴影
 */
+ (void)setViewStyle:(UIView *)view;
/**
* 设置TextField风格
*/
+ (void)setTextFieldStyle:(UITextField *)textField andTitle:(NSString *)text;

/**
 * 将view的边角磨圆, 上面可以废弃
 */
+ (void)viewWithCorner:(UIView *)view withRadius:(CGFloat)radius;

/**
 * 状态栏高度
 */
+ (CGFloat)statusHeight;

/**
 * 导航栏高度
 */
+ (CGFloat)navigationBarHeight;

/**
 * 状态栏高度
 */
+ (CGFloat)tabBarHeight;

/**
 * 屏幕高度
 */
+ (CGFloat)screenHeight;

/**
 * 屏幕宽度
 */
+ (CGFloat)screenWidth;

/**
 * 创建普通label
 
 * 默认左对齐
 * 默认单行
 */
+ (UILabel *)labelWith:(NSString *)text size:(CGFloat)size color:(UIColor *)color;
/**
 *  计算文字高度
 */
+ (float)textSizeWithFont:(UIFont *)font andTextString:(NSString *)text andSize:(CGSize)size;
/**
 * 图片拉伸
 */
+ (UIImage *)stretchImage:(NSString *)imgName;
/**
 *  图片压缩
 */
+ (NSData *)JPEGCompress:(UIImage *)img rate:(float)rate;
+ (NSData *)PNGCompress:(UIImage *)img rate:(float)rate;
@end
