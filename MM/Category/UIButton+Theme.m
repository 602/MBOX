//
//  UIButton+Theme.m
//  QQing
//
//  Created by 李杰 on 4/20/15.
//
//

#import "UIButton+Theme.h"

@implementation UIButton (Theme)

- (void)thematized {
    [self setNormalBackgroundColor:[UIColor themeBlueColor]
            disableBackgroundColor:[UIColor fontGray_three_Color]];
    
    [self setTitleColor:[UIColor whiteColor]];
    
    [self circularCorner];
}

- (void)thematizedWithBackgroundColor:(UIColor*)backgroundColor
{
    [self setNormalBackgroundColor:backgroundColor
            disableBackgroundColor:[UIColor fontGray_three_Color]];
    [self setBackgroundImage:[UIImage imageWithColor:backgroundColor] forState:UIControlStateHighlighted];
    [self setBackgroundColor:backgroundColor];
    [self setTitleColor:[UIColor whiteColor]];
    
    [self circularCorner];
}

- (void)circularCorner {
    [self circular:3.0f];
}

- (void)circularShape {
    [self circular:MIN(self.width, self.height) / 2];
}

- (void)circular:(CGFloat)dist {
    [[self layer] setCornerRadius:dist];
    [[self layer] setMasksToBounds:YES];
    
    [self setAdjustsImageWhenHighlighted:NO];
    [self setShowsTouchWhenHighlighted:NO];
}

- (void)setBorderWidth:(CGFloat)width withColor:(UIColor *)color {
    self.layer.borderColor = [color CGColor];
    self.layer.borderWidth = width;
}

- (void)setTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateSelected];
}

- (void)setTitleColor:(UIColor *)tc backgroundColor:(UIColor *)bc {
    [self setTitleColor:tc];
    
    [self setImage:[UIImage imageWithColor:bc] forState:UIControlStateNormal];
    [self setImage:[UIImage imageWithColor:bc] forState:UIControlStateHighlighted];
}

- (void)setNormalBackgroundColor:(UIColor *)color disableBackgroundColor:(UIColor *)color2 {
    [self setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:color2] forState:UIControlStateDisabled];
}

@end
