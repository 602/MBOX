//
//  UIUtils.m
//  QQing
//
//  Created by 王涛 on 3/1/15.
//
//

#import "UIUtils.h"

@implementation UIUtils

+ (void)viewWithCorner:(UIView *)view withRadius:(CGFloat)radius {
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
}

+ (CGFloat)statusHeight {
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    return rectStatus.size.height;
}

+ (CGFloat)navigationBarHeight {
    UINavigationController *vc =[UINavigationController new];
    CGRect rectNav = [vc.navigationBar frame];
    return rectNav.size.height;
}

+ (CGFloat)tabBarHeight {
    UITabBarController *vc = [UITabBarController new];
    CGRect rectTab = [vc.tabBar frame];
    return rectTab.size.height;
}

+ (CGFloat)screenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)screenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (UILabel *)labelWith:(NSString *)text size:(CGFloat)size color:(UIColor *)color {
    UILabel *lbl = [[UILabel alloc] init];
    
    // fixme 应该自动计算长宽
    lbl.font = [UIFont systemFontOfSize:size];
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.textColor = color;
    lbl.numberOfLines = 0;
    lbl.lineBreakMode = NSLineBreakByCharWrapping;
    lbl.text = text;
    
    CGSize contentSize = [text textSizeWithFont:lbl.font
                              constrainedToSize:CGSizeZero
                                  lineBreakMode:NSLineBreakByWordWrapping];
    lbl.width = contentSize.width;
    lbl.height = contentSize.height;
    
    return lbl;
}

+ (void)setViewStyle:(UIView*)view {
    if (!view) {
        return;
    }
    view.layer.borderColor = [UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:.1].CGColor;
    view.layer.borderWidth = 1;
}

+ (void)setTextFieldStyle:(UITextField *)textField andTitle:(NSString *)text{

    if (text) {
        UILabel *phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 21)];
        phoneLbl.backgroundColor = [UIColor clearColor];
        phoneLbl.textColor = [UIColor fontGray_two_Color];
        phoneLbl.text = text;
        phoneLbl.font = [UIFont systemFontOfSize:16];
        
        textField.leftView = phoneLbl;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.textColor = [UIColor fontGray_one_Color];
        
        [textField setValue:[UIColor fontGray_four_Color] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];

    }else{
    
        textField.textColor = [UIColor fontGray_one_Color];
    }
}

+ (float)textSizeWithFont:(UIFont *)font andTextString:(NSString *)text andSize:(CGSize)size {
    NSRange allRange = [text rangeOfString:text];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];

    [attrStr addAttribute:NSFontAttributeName
                    value:font
                    range:allRange];
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect Size = [attrStr boundingRectWithSize:size
                                               options:options
                                               context:nil];
    float Height = ceilf(Size.size.height);
    return Height;
}

+ (UIImage *)stretchImage:(NSString *)imgName {

    UIImage* img =[UIImage imageNamed:imgName];//原图
    UIEdgeInsets edge=UIEdgeInsetsMake(5, 10, 5,10);
   //UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
    //UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图
    img= [img resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    return img;
}
+ (NSData *)JPEGCompress:(UIImage *)img rate:(float)rate {
    NSData *imageData = UIImageJPEGRepresentation(img, rate);
    return imageData;
}

+ (NSData *)PNGCompress:(UIImage *)img rate:(float)rate {
    NSData *imageData = UIImagePNGRepresentation(img);
    return imageData;
}
@end
