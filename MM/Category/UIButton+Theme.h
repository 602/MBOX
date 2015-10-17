//
//  UIButton+Theme.h
//  QQing
//
//  Created by 李杰 on 4/20/15.
//
//

#import <UIKit/UIKit.h>

@interface UIButton (Theme)

/**
 * 主题特化
 */
- (void)thematized;

/**
 * 主题特化,指定背景颜色
 */
- (void)thematizedWithBackgroundColor:(UIColor*)backgroundColor;

/**
 * 加圆角
 */
- (void)circularCorner;

- (void)circularShape; // 圆形

- (void)circular:(CGFloat)dist;

/**
 *  设置边框
 */

- (void)setBorderWidth:(CGFloat)width withColor:(UIColor *)color;

/**
 * 设置颜色
 
 * 状态：默认态、高亮态
 */

- (void)setTitleColor:(UIColor *)color;

- (void)setTitleColor:(UIColor *)tc backgroundColor:(UIColor *)bc;

/**
 * 设置背景色
 
 * 用image去实现
 */

- (void)setNormalBackgroundColor:(UIColor *)color disableBackgroundColor:(UIColor *)color2;

@end
