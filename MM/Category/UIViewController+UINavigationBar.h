//
//  UIViewController+UINavigationBar.h
//  QQing
//
//  Created by 李杰 on 2/15/15.
//
//

#import <UIKit/UIKit.h>

/*
 * FIXME: 还没有完善
 
 * 不打算建立基控制器类，用类别来实现常用的操作
 */

@interface UIViewController (UINavigationBar)

@property (nonatomic, strong) NSString *navTitleString;
@property (nonatomic, strong) UIView *navTitleView;

- (void)setNavLeftItemWithImage:(NSString *)image target:(id)target action:(SEL)action;
- (void)setNavLeftItemWithName:(NSString *)name target:(id)target action:(SEL)action;

- (void)setNavRightItemWithImage:(NSString *)image target:(id)target action:(SEL)action;
- (void)setNavRightItemWithName:(NSString *)name target:(id)target action:(SEL)action;

@end
