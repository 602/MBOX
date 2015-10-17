//
//  Utils.m
//  QQing
//
//  Created by 王涛 on 1/28/15.
//
//
#import <objc/message.h>

#import "Utils.h"
#import "UIAlertView+fram.h"

typedef NS_ENUM(NSInteger, LevelType){
    levelTypeRed = 1,
    levelTypeYellow = 2,
    levelTypeBlue = 3,
    levelTypeGold = 4,
};

@implementation Utils

SINGLETON_GCD(Utils);

- (instancetype)init {
    if (self = [super init]) {
        // loadingView的引用计数，但不是最好的方式！fixme
        self.hudReference = 0;
    }
    
    return self;
}

#pragma mark - LocationManager
+ (CLLocationManager *)locMgr {
    static CLLocationManager *_locMgr = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        _locMgr = [[CLLocationManager alloc] init];
    });
    
    return _locMgr;
}

#pragma mark - 计算纬度之间的距离

+ (double)calculateDistance:(double)lat1 lng1:(double)lng1 lat2:(double)lat2 lng2:(double)lng2 {
    double distance = [LocationModel countDistanceBetween:[LocationModel modelWithLongitude:lng1 latitude:lat1] with:[LocationModel modelWithLongitude:lng2 latitude:lat2]];
    return distance;
}

#pragma mark - Progress, Toast

+ (MBProgressHUD *)showProgressHUDWithText:(NSString *)text {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:[[UIApplication sharedApplication] keyWindow]];

    // Full screen show.
    [[[UIApplication sharedApplication] keyWindow] addSubview:hud];
    [hud bringToFront];
    [hud show:YES];
    
    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = YES;
    hud.square = YES;
    
    return hud;
}

+ (void)showLoadingView {
    if ([Utils sharedUtils].hudReference) return;
    
    [Utils sharedUtils].hudReference ++;
    
    [[GCDQueue mainQueue] queueBlock:^{
        [[Utils sharedUtils] setHud:[Utils showProgressHUDWithText:nil]]; // fixme: 创建＋show，用queue方式不合适。
    }];
}

+ (void)hideLoadingView {
    if ([Utils sharedUtils].hudReference < 0) {
        QQLog(@"Exception occurred!!! hudReference overflow!!");
        
        [Utils sharedUtils].hudReference = 0;
    }
    
    if (![Utils sharedUtils].hudReference) return;
    
    [[GCDQueue mainQueue] queueBlock:^{
        if ([Utils sharedUtils].hud) {
            [[Utils sharedUtils].hud hide:YES];
            [[Utils sharedUtils] setHud:nil];
            
            [Utils sharedUtils].hudReference --;
        }
    }];
}

+ (void)showToastWithText:(NSString *)text {
    [Utils showToastWithText:text isLoading:NO isBottom:NO];
}

+ (void)showToastWithText:(NSString *)text isLoading:(BOOL)isLoading isBottom:(BOOL)isBottom {
    [[GCDQueue mainQueue] queueBlock:^{
        UIAlertView *alertViewRe = [[UIAlertView alloc]
                                    initWithTitle:text
                                    message:nil
                                    delegate:self
                                    cancelButtonTitle:nil
                                    otherButtonTitles:nil,nil];
        
        [alertViewRe show];
        [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:alertViewRe];
        [alertViewRe dismissAfter:1];
    }];
}

+ (void)showAlertView:(NSString*)title :(NSString*)message :(NSString*)enterStr {
    
    UIAlertView *alertViewRe = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:enterStr,nil];
    
    [alertViewRe show];
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:alertViewRe];
}

#pragma mark - TabBar control

+ (void)hideTabBar:(UIViewController *)vc {
    if (vc.tabBarController.tabBar.hidden == YES) {
        return;
    }
    
    UIView *contentView;
    if ( [[vc.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ) {
        contentView = [vc.tabBarController.view.subviews objectAtIndex:1];
    } else {
        contentView = [vc.tabBarController.view.subviews objectAtIndex:0];
    }
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + vc.tabBarController.tabBar.frame.size.height);
    vc.tabBarController.tabBar.hidden = YES;
}

+ (void)showTabBar:(UIViewController *)vc {
    if (vc.tabBarController.tabBar.hidden == NO) {
        return;
    }
    UIView *contentView;
    if ([[vc.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
        contentView = [vc.tabBarController.view.subviews objectAtIndex:1];
    } else {
        contentView = [vc.tabBarController.view.subviews objectAtIndex:0];
    }
    
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - vc.tabBarController.tabBar.frame.size.height);
    vc.tabBarController.tabBar.hidden = NO;
}

#pragma mark - 弹出框

+ (UIImage *)screenshotForView:(UIView *)view {
    UIGraphicsBeginImageContext(view.bounds.size);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    // hack, helps w/ our colors when blurring
    NSData *imageData = UIImageJPEGRepresentation(image, 1); // convert to jpeg
    image = [UIImage imageWithData:imageData];
    imageData = nil;
    
    return image;
}

- (void)handleCloseAction:(id)sender {
    [Utils dismissPopup];
}

+ (void)showPopup:(UIView *)contentView {
    if (!contentView) return;
    
    Utils *utils = [Utils sharedUtils];
    
    if (utils.popup) return;
    
    // 圆角
    contentView.layer.cornerRadius = 4.f;
    contentView.layer.masksToBounds = YES;
    
    // 内容图之下
    utils.contentHolder = [[UIView alloc] initWithFrame:contentView.frame];
    utils.contentHolder.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    [utils.contentHolder addSubview:contentView];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    utils.popup = [[UIView alloc] initWithFrame:window.rootViewController.view.bounds]; // main view

    // 获取截屏图，并高斯模糊
    UIImage *image = [Utils screenshotForView:window.rootViewController.view];
    image = [image boxblurImageWithBlur:0.1];
    utils.blurView = [[UIImageView alloc] initWithImage:image];
    utils.blurView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    utils.blurView.alpha = 0;
    [[Utils sharedUtils].popup addSubview:utils.blurView];

    // coverView
    utils.coverView = [[UIView alloc] initWithFrame:window.rootViewController.view.bounds];
    utils.coverView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    utils.coverView.backgroundColor = [UIColor colorWithRed:00/255.0 green:00/255.0 blue:00/255.0 alpha:0.5];
    [[Utils sharedUtils].popup addSubview:utils.coverView];
    
    // 点触事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:[Utils sharedUtils] action:@selector(handleCloseAction:)];
    [utils.coverView addGestureRecognizer:tapGesture];
    
    [utils.coverView addSubview:utils.contentHolder];
    utils.contentHolder.center = CGPointMake(utils.coverView.bounds.size.width/2,
                                       utils.coverView.bounds.size.height/2);
    utils.coverView.alpha = 0;
    
    utils.popup.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [window.rootViewController.view addSubview:utils.popup];
    [utils.popup bringToFront];
    
    utils.contentHolder.transform = CGAffineTransformMakeScale(0.8, 0.8);
    utils.initialPopupTransform = utils.contentHolder.transform;
//    [window.layer setMasksToBounds:YES];
    [UIView animateWithDuration:0.3
                     animations:^{
                         utils.coverView.alpha = 1;
                         utils.blurView.alpha = 1;
                         
                         utils.contentHolder.transform = CGAffineTransformIdentity;
                     }];
}

+ (void)dismissPopup {
    Utils *utils = [Utils sharedUtils];
    
    [UIView animateWithDuration:.3f
                     animations:^{
                         utils.coverView.alpha = 0;
                         utils.contentHolder.transform = utils.initialPopupTransform;
                         utils.blurView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [utils.popup removeFromSuperview];
                         utils.popup = nil;
                         utils.blurView = nil;
                         utils.coverView = nil;
                     }];
}

#pragma mark -
+ (void)addLocalNotification:(NSString*)title :(NSString*)content {
    //定义本地通知对象
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    //设置调用时间
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5.0];//通知触发的时间，10s以后
    notification.repeatInterval = 2;//通知重复次数
    //notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
    
    //设置通知属性
    notification.alertBody = content; //通知主体
    notification.applicationIconBadgeNumber = 1;//应用程序图标右上角显示的消息数
    notification.alertAction = @"打开应用"; //待机界面的滑动动作提示
    notification.alertLaunchImage = @"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
    //notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    notification.soundName = @"msg.caf";//通知声音（需要真机才能听到声音）
    
    //设置用户信息
    //notification.userInfo=@{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

+ (void)removeAllLocalNotification {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

#pragma mark - Print 对象的属性值：最下层类结构

+ (void)printObject:(id)obj {
    const char *classname = object_getClassName(obj);
    id objclass_ = objc_getClass(classname);
    (void) objclass_;
    NSMutableString *desc = [NSMutableString stringWithFormat:@"%s {", classname];
    
    id objclass = [obj class];
    unsigned int propCount, i;
    objc_property_t *properties = class_copyPropertyList(objclass, &propCount);
    for (i = 0; i < propCount; i++) {
        objc_property_t property = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
        id value = [obj valueForKey:propName];
        
        [desc appendFormat:@" %@=%@ ", propName, value];
    }
    
    NSLog(@"%@}", desc);
}

+ (BOOL)isSimCardInstalled {
    return YES;
}

+ (void)makePhoneCall:(NSString *)tel {
    // Note: 用该方法，主动结束后，返回系统界面，不返回应用界面
//    [[UIApplication sharedApplication] openURL:phoneUrl];
    
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"tel:", tel]];// 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:callWebview];
    [callWebview bringToFront];
}

+ (UIView*)setLevelImagewithIntegral:(int)integral{

    LevelType levelType = levelTypeRed;
    int level = 0;
    
    if (integral<101) {
        
        levelType = levelTypeRed;
        
        if (integral<6) {
            level=1;
        }else if (integral<16){
            
            level=2;
        }else if (integral<31){
            
            level=3;
        }else if (integral<61){
            
            level=4;
        }else{
            
            level=5;
        }
    }else if (integral<306){
        
        levelType = levelTypeYellow;
        
        if (integral<141) {
            level=1;
        }else if (integral<181){
            
            level=2;
        }else if (integral<221){
            
            level=3;
        }else if (integral<261){
            
            level=4;
        }else{
            
            level=5;
        }
    }else if (integral<601){
        
        levelType = levelTypeBlue;
        
        if (integral<366) {
            level=1;
        }else if (integral<426){
            
            level=2;
        }else if (integral<486){
            
            level=3;
        }else if (integral<546){
            
            level=4;
        }else{
            
            level=5;
        }
        
    }else{
        
        levelType = levelTypeGold;
        
        if (integral<801) {
            level=1;
        }else if (integral<1001){
            
            level=2;
        }else if (integral<1501){
            
            level=3;
        }else if (integral<2501){
            
            level=4;
        }else{
            
            level=5;
        }
        
        
    }
    
    UIView* returnView = [[UIView alloc]initWithFrame:CGRectZero];
    switch (levelType) {
        case levelTypeRed:{
            
            for (int i =0; i<level; i++) {
               // UIImageView* starImage = [[UIImageView alloc]initWithFrame:CGRectMake((level-1)*20+5, 0, 20, 20)];
                UIImageView* starImage = [[UIImageView alloc]initWithFrame:CGRectMake(i*20+25, 0, 20, 20)];
                starImage.image = [UIImage imageNamed:@"icon_heart"];
                [returnView addSubview:starImage];
                returnView.width = 45*level;
                returnView.height = 20;
            }
            return returnView;
            
            
        }
            break;
        case levelTypeYellow:{

            for (int i =0; i<level; i++) {
                UIImageView* starImage = [[UIImageView alloc]initWithFrame:CGRectMake(i*20+25, 0, 20, 20)];
                starImage.image = [UIImage imageNamed:@"icon_diamond"];
                [returnView addSubview:starImage];
                returnView.width = 20*level;
                returnView.height = 20;
            }
            return returnView;
            
        }
            break;
        case levelTypeBlue:{

            for (int i =0; i<level; i++) {
                UIImageView* starImage = [[UIImageView alloc]initWithFrame:CGRectMake(i*20+25, 0, 20, 20)];
                starImage.image = [UIImage imageNamed:@"icon_blue_crown"];
                [returnView addSubview:starImage];
                returnView.width = 20*level;
                returnView.height = 20;
            }
            return returnView;
            
        }
            break;
        case levelTypeGold:{
            
            for (int i =0; i<level; i++) {
                UIImageView* starImage = [[UIImageView alloc]initWithFrame:CGRectMake(i*20+25, 0, 20, 20)];
                starImage.image = [UIImage imageNamed:@"icon_yellow_crown"];
                [returnView addSubview:starImage];
                returnView.width = 20*level;
                returnView.height = 20;
            }
            return returnView;
        }
            break;
            
        default:
            break;
    }
}

+ (NSString *)getVersion{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *version = [data objectForKey:@"CFBundleShortVersionString"];
    
    return version;
}

@end
