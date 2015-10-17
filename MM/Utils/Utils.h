//
//  Utils.h
//  QQing
//
//  Created by 王涛 on 1/28/15.
//
//
@interface Utils : NSObject

// 获取定位服务

+ (CLLocationManager *)locMgr;

/*
 * 计算纬度之间的距离
 * @param 经纬度
 * @return 距离 米
 */
+ (double)calculateDistance:(double)lat1 lng1:(double)lng1 lat2:(double)lat2 lng2:(double)lng2;

// 菊花
+ (MBProgressHUD *)showProgressHUDWithText:(NSString *)text;

@property (nonatomic, assign) NSInteger hudReference;
@property (nonatomic, strong) MBProgressHUD *hud;
+ (void)showLoadingView;
+ (void)hideLoadingView;

// 提示文字
+ (void)showToastWithText:(NSString *)text;
+ (void)showToastWithText:(NSString *)text isLoading:(BOOL)isLoading isBottom:(BOOL)isBottom;

// AlertView
+ (void)showAlertView:(NSString*)title :(NSString*)message :(NSString*)enterStr;

// TabBar 控制
+ (void)hideTabBar:(UIViewController *)vc;

+ (void)showTabBar:(UIViewController *)vc;

// 背景虚化弹出框
@property (nonatomic, strong) UIView *popup;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIImageView *blurView;
@property (nonatomic, strong) UIView *contentHolder;
@property (nonatomic, assign) CGAffineTransform initialPopupTransform; // contentHolder
+ (void)showPopup:(UIView *)pop;
+ (void)dismissPopup;

// 本地通知
+ (void)addLocalNotification:(NSString *)title :(NSString *)content;
+ (void)removeAllLocalNotification;

// Print 对象的属性值：最下层类结构
+ (void)printObject:(id)obj;

/**
 * 系统工具
 */
+ (BOOL)isSimCardInstalled;//判断是否有sim卡
+ (void)makePhoneCall:(NSString *)tel;//打电话

//根据积分设置星标，星标替换成自己的
+ (UIView *)setLevelImagewithIntegral:(int)integral;

/**
 *  获取版本信息
 */
+ (NSString *)getVersion;

@end
