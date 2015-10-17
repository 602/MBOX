//
//  UIColor+theme.m
//  QQing
//
//  Created by 李杰 on 1/22/15.
//
//

#import "UIColor+theme.h"

@implementation UIColor (theme)

// Examples.
+ (UIColor *)mainOrangeColor {
    return [UIColor colorWithRed:1.0f green:0.4f blue:0.0f alpha:1.0f];
}

+ (UIColor *)lightOrangeColor {
    return [UIColor colorWithRed:1.0f green:0.6f blue:0.2f alpha:1.0f];
}

+ (UIColor *)paleOrangeColor {
    return [UIColor colorWithRed:(234.0f / 255.0f) green:(232.0f / 255.0f) blue:(224.0f / 255.0f) alpha:1.0f];
}

+ (UIColor *)themeBlueColor {
    return [UIColor colorWithRed:(57.0f / 255.0f) green:(106.0f / 255.0f) blue:(180.0f / 255.0f) alpha:1.0f];
}

+ (UIColor *)themeGreenColor {
    return [UIColor colorWithRed:(225.0f / 255.0f) green:(63.0f / 255.0f) blue:(34.0f / 255.0f) alpha:1.0f];
}

+ (UIColor *)themeGreenTwoColor {
    return [UIColor colorWithRed:(140.0f / 255.0f) green:(200.0f / 255.0f) blue:(68.0f / 255.0f) alpha:1.0f];
}

+ (UIColor *)themeGrayColor {
    return [UIColor colorWithRed:247.0/255 green:247.0/255 blue:247.0/255 alpha:1.0f];
}

+ (UIColor *)themeRedColor {
    return [UIColor colorWithRed:244./255. green:124./255. blue:145./255. alpha:1.0];
}

+ (UIColor *)themeGreenColorWithAlpha:(CGFloat)alpha {
    
    return [UIColor colorWithRed:(140.0f / 255.0f) green:(185.0f / 255.0f) blue:(82.0f / 255.0f) alpha:alpha];
}

+ (UIColor *)navigationBarTintColor {
    return [UIColor colorWithRed:051/255 green:051/255 blue:051/255 alpha:1.0f];
}

+ (UIColor *)textDarkGreenColor {
    return [UIColor colorWithRed:(71.0f / 255.0f) green:(129.0f / 255.0f) blue:(52.0f / 255.0f) alpha:1.0f];
}

+ (UIColor *)courseEdColor {
    return [UIColor fontGray_four_Color];
}

+ (UIColor *)courseIngColor {
    return [UIColor themeBlueColor];
}

+ (UIColor *)courseWillColor {
    return [UIColor themeGreenColor];
}

+ (UIColor *)courseWaitColor {
    return [UIColor themePinkColor];
}

+ (UIColor *)courseDealingColor {
    return [UIColor fontGray_three_Color];
}

+ (UIColor *)colorOnTouched {
    return [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
}

+ (UIColor *)colorOnSelected {
    return [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0];
}

+ (UIColor *)sscourseCellBorderColor {
    return [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
}

+(UIColor *)sscourseNewCellBorderColor {
    return [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
}

+ (UIColor *)sscourseCellContentColor {
    return [UIColor colorWithRed:240/255.0 green:239/255.0 blue:240/255.0 alpha:1.0];
}

+(UIColor *)schePurpleColor {
    return [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1.0];
}

+ (UIColor *)schePurpleColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:alpha];
}
+ (UIColor *)themePinkColor {

    return [UIColor colorWithRed:255.0/255 green:125.0/255 blue:140.0/255 alpha:1.0];
}
+ (UIColor *)backGroundGrayColor {
    
    return [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
}

+ (UIColor *)fontGray_one_Color{

    return [UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1.0];
}
+ (UIColor *)fontGray_two_Color{
    
    return [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1.0];
}
+ (UIColor *)fontGray_three_Color{
    
    return [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
}
+ (UIColor *)fontGray_four_Color{
    return [UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1.0];
}


@end

