//
//  AppAppearance.h
//  QQing
//
//  Created by 王涛 on 5/20/15.
//
//

#import <Foundation/Foundation.h>

/**
 *  应用程序的外观 参数
 */
@interface AppAppearance : NSObject

@property (nonatomic, assign) CGFloat menuFontSize; // tabbar
//@property (nonatomic, assign)

- (void)statusBarAppearance;

- (void)navigationBarAppearance;

- (void)tabBarItemAppearance;

+ (instancetype)appearance;

@end

#define kScreenWidth [UIUtils screenWidth]