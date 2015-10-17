//
//  UIViewController+UINavigationBar.m
//  QQing
//
//  Created by 李杰 on 2/15/15.
//
//

#import "UIViewController+UINavigationBar.h"

@implementation UIViewController (UINavigationBar)
@dynamic navTitleString;
@dynamic navTitleView;

#pragma mark - Utility

+ (CGSize)sizeOfContent:(NSString *)name {
    if (name.length == 0) {
        return CGSizeMake(0, 0);
    }
    NSMutableString *string = [NSMutableString stringWithString:name];
    return [string textSizeWithFont:[UIFont systemFontOfSize: 15] constrainedToSize:CGSizeMake(100, 1000) lineBreakMode:NSLineBreakByWordWrapping];  //一行宽度最大为 100 高度1000
}

#pragma mark - Settings

- (NSString *)navTitleString {
    return self.navigationItem.title ? self.navigationItem.title : self.title;
}

- (void)setNavTitleString:(NSString *)titleString {
    //自定义标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName: @"Helvetica" size: 18.0];
    titleLabel.textColor = [UIColor fontGray_one_Color];//设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = titleString;
    self.navigationItem.titleView = titleLabel;
}

- (UIView *)navTitleView {
    return self.navigationItem.titleView;
}

- (void)setNavTitleView:(UIView *)view {
    [self setNavigationBarTitle:view];
}

- (void)setNavigationBarTitle:(id)content {
    if (content) {
        if ([content isKindOfClass:[NSString class]]) {
            self.navigationItem.titleView = nil;
            self.navigationItem.title = content;
        }
        else if ([content isKindOfClass:[UIImage class]]) {
            UIImageView * imageView = [[UIImageView alloc] initWithImage:content];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            
            self.navigationItem.titleView = imageView;
        }
        else if ( [content isKindOfClass:[UIView class]] )
        {
            UIView *view = content;
            
            view.backgroundColor = [UIColor clearColor];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            view.autoresizesSubviews = YES;
            view.x = self.view.bounds.size.width/2;
            
            self.navigationItem.titleView = content;
        }
        else if ( [content isKindOfClass:[UIViewController class]] )
        {
            self.navigationItem.titleView = ((UIViewController *)content).view;
        }
    }
}

- (void)setNavLeftItemWithImage:(NSString *)image target:(id)target action:(SEL)action {
    // 左边按钮
    UIImage *nimg = [UIImage imageNamed:image];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, nimg.size.width, nimg.size.height)];
    [btn setImage:nimg forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    //navigation左右按钮位置调节
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;//此处修改到边界的距离，请自行测试
        
        if (leftButton)
        {
            [self.navigationItem setLeftBarButtonItems:@[negativeSeperator, leftButton]];
        }
        else
        {
            [self.navigationItem setLeftBarButtonItems:@[negativeSeperator]];
        }
        
        
    }
    else
    {
        [self.navigationItem setLeftBarButtonItem:leftButton animated:NO];
    }
    
    
    //[self.navigationItem setLeftBarButtonItem:leftButton];
}

- (void)setNavLeftItemWithName:(NSString *)name target:(id)target action:(SEL)action {
    NSString *leftTitle = name;
    CGSize titleSize = [UIViewController sizeOfContent: leftTitle];
    UIButton *t = [UIButton buttonWithType:UIButtonTypeCustom];
    [t setFrame:CGRectMake(0, 0, titleSize.width, self.navigationController.navigationBar.frame.size.height)];
    [t setTitle:leftTitle forState:UIControlStateNormal];
    [t setTintColor:[UIColor navigationBarTintColor]];
    [t addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [t setBackgroundColor:[UIColor clearColor]];
    [t setTitleColor:[UIColor fontGray_one_Color] forState:UIControlStateNormal];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:t];
    
    [self.navigationItem setLeftBarButtonItem:leftBtn];
}

- (void)setNavRightItemWithImage:(NSString *)image target:(id)target action:(SEL)action {
    
    UIImage *nimg = [UIImage imageNamed:image];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, nimg.size.width, nimg.size.height)];
    [btn setImage:nimg forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self.navigationItem setRightBarButtonItem:rightBtn];
}

- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action {
    // 右边按钮
    NSString *rightTitle = name;

    CGSize titleSize = [UIViewController sizeOfContent: rightTitle];
    UIButton *t = [UIButton buttonWithType:UIButtonTypeCustom];
    [t setFrame:CGRectMake(0, 0, titleSize.width+12, self.navigationController.navigationBar.frame.size.height)];
    t.titleLabel.font = [UIFont systemFontOfSize:16];
    [t setTitle:rightTitle forState:UIControlStateNormal];
    [t setTitleColor:[UIColor colorWithRed:51.0/255 green:51.0/255 blue:51.0/255 alpha:1] forState:UIControlStateNormal];
    [t addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [t setBackgroundColor:[UIColor clearColor]];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:t];
    
    //navigation左右按钮位置调节
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;//此处修改到边界的距离，请自行测试
        
        if (rightBtn)
        {
            [self.navigationItem setRightBarButtonItems:@[negativeSeperator, rightBtn]];
        }
        else
        {
            [self.navigationItem setRightBarButtonItems:@[negativeSeperator]];
        }
        
        
    }
    else
    {
        [self.navigationItem setRightBarButtonItem:rightBtn animated:NO];
    }
}

@end
