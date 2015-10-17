//
//  UIColor+theme.h
//  QQing
//
//  Created by 李杰 on 1/22/15.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (theme)

// For example  [UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:100]

+ (UIColor *)themeGrayColor;
+ (UIColor *)mainOrangeColor;
+ (UIColor *)lightOrangeColor;
+ (UIColor *)paleOrangeColor;
+ (UIColor *)themePinkColor;

+ (UIColor *)themeGreenColor;
+ (UIColor *)themeGreenTwoColor;
+ (UIColor *)themeGreenColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)themeBlueColor;
//背景灰
+ (UIColor *)backGroundGrayColor;
+ (UIColor *)themeRedColor;

/**
 * 字体灰 1-4 颜色递减
 */
+ (UIColor *)fontGray_one_Color;
+ (UIColor *)fontGray_two_Color;
+ (UIColor *)fontGray_three_Color;
+ (UIColor *)fontGray_four_Color;

// 导航栏颜色风格
+ (UIColor *)navigationBarTintColor;

+ (UIColor *)textDarkGreenColor;

+ (UIColor *)courseEdColor;
+ (UIColor *)courseIngColor;
+ (UIColor *)courseWillColor;
+ (UIColor *)courseWaitColor;
+ (UIColor *)courseDealingColor;

+ (UIColor *)btnColorForCancelCourse;
+ (UIColor *)btnColorForRenewCourse;

/**
 * 单选上课时间 颜色
 */
+ (UIColor *)sscourseCellContentColor;
+ (UIColor *)sscourseCellBorderColor;
+ (UIColor *)sscourseNewCellBorderColor;
/**
 * 自定义view，按下态等
 */
+ (UIColor *)colorOnTouched;
+ (UIColor *)colorOnSelected;

/**
 * 授课时间课程表 颜色表
 */
+ (UIColor *)schePurpleColor;
+ (UIColor *)schePurpleColorWithAlpha:(CGFloat)alpha;

/**
 * 
 */

@end
