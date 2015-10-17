//
//  AppDelegate.m
//  myProject
//
//  Created by 王涛 on 15/5/28.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuVC.h"
#import "HotVC.h"
#import "ExchangeVC.h"
#import "MeVC.h"
#import "LoginVC.h"
#import "UMessage.h"

#import "NetWorkRequest.h"

@interface AppDelegate ()

@end

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define _IPHONE80_ 80000


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //友盟推送设置
    
    [UMessage startWithAppkey:@"55faca4e67e58e276900382e" launchOptions:launchOptions];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    
    //for log
    [UMessage setLogEnabled:YES];
    /*
     * 初始化网络接口
     */
    [self initNetwork];
    /**
     *  窗口初始化
     */
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    if ([[Cache sharedCache] cookie]) {
        [self presentSigninViewController:YES];
    }else {
        [self presentSigninViewController:NO];
    }
    return YES;
}

//推送设置
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [UMessage registerDeviceToken:deviceToken];
    QQLog(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [UMessage didReceiveRemoteNotification:userInfo];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    QQLog(@"Failed to get token, error:%@", error_str);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - Initialization
- (void)initNetwork {
    //给网络请求设置基本URL
    [[NetWorkRequest sharedNetWorkRequest] setBasicURL:kApiBasePublicUrl];
}
#pragma mark - Navigation control

- (void)replaceRootControllerBy:(RootViewControllerType)type {
    switch (type) {
        case kRootViewControllerTypeLoginVC:
        {
           [self presentSigninViewController:NO];
        }
            break;
            
        case kRootViewControllerTypeMainVC:
        {
            [self presentMenuViewController];
        }
            
        default:
            break;
    }
}

#pragma mark - Main view branching

// 欢迎页
- (void)presentTutorialViewController {
        //进入欢迎页
    
}

//登录
- (void)presentSigninViewController:(BOOL)autoLogin {
    if (autoLogin) {
        [[Cache sharedCache] setIsAutoLogin:YES];
        [self presentMenuViewController];
    }else {
        [[Cache sharedCache] setIsAutoLogin:NO];
        LoginVC *loginVc = [[LoginVC alloc]_initWithNib];
        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVc];
        self.window.rootViewController = loginNav;
        [AppAppearance appearance];
    }
}


// 应用主页
- (void)presentMenuViewController {
    // 首页
    MenuVC *menuVC = [[MenuVC alloc] _initWithNib];
    UINavigationController *mnNav = [[UINavigationController alloc] initWithRootViewController:menuVC];
    
    HotVC *hotVC = [[HotVC alloc] _initWithNib];
    UINavigationController *hotNav = [[UINavigationController alloc]initWithRootViewController:hotVC];
    
    ExchangeVC *excVC = [[ExchangeVC alloc] _initWithNib];
    UINavigationController *excNav = [[UINavigationController alloc]initWithRootViewController:excVC];
    
    MeVC *meVC = [[MeVC alloc] _initWithNib];
    UINavigationController *meNav = [[UINavigationController alloc]initWithRootViewController:meVC];
    
    NSArray *viewArray = [NSArray arrayWithObjects:mnNav, hotNav, excNav, meNav, nil];
    
    UITabBarController* tabbarC = [[UITabBarController alloc]init];
    tabbarC.viewControllers = viewArray;
    [AppAppearance appearance];
    
    [self.window setRootViewController:tabbarC];
}
@end
