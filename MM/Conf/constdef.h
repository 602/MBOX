//
//  constdef.h
//  QQing
//
//  Created by 王涛 on 1/28/15.
//
//

#ifndef QQing_constdef_h
#define QQing_constdef_h

/**
 * 程序配置常量
 */

// 服务器本机调试地址
#define kApiBaseUrl @"http://demo.top66.net/mobile/"
// 测试服务器测试地址
#define kApiBasePublicUrl @"http://121.41.94.101:8098/"
// 正式服务器地址
#define kApiFormalUrl @"http://demo.top66.net/mobile/"
// 集群测试地址
#define kApiTempUrl @"http://demo.top66.net/mobile/"

/**
 * 调试版本的宏开关
 * 如果注释，则切换到   正式环境0
 */
#define __DEBUG_VERSION 1

#if !__DEBUG_VERSION
#   define kApiBasePublicUrl kApiFormalUrl
#endif

/**
 * 图片服务url
 */
#if __DEBUG_VERSION
#   define kPictureUrl          @"http://demo.top66.net/mobile/"
#else
#   define kPictureUrl          @"http://demo.top66.net/mobile/"
#endif

//获取文件名
#define kFileNameUrl @"http://demo.top66.net/mobile/"

#if __DEBUG_VERSION
static NSString * PICHEADUPLOADURL  =   @"http://demo.top66.net/mobile/";      //头像上传URL
static NSString * PICUPLOADURL      =   @"http://demo.top66.net/mobile/";          //图片上传URL
static NSString * PICTHIRDUPLOADURL =   @"http://demo.top66.net/mobile/";     //第三方场地图片上传

static NSString * PICDOWNLADURL     =   @"http://demo.top66.net/mobile/";         //图片下载URL
#else
static NSString * PICHEADUPLOADURL  =   @"http://demo.top66.net/mobile/";      //头像上传URL
static NSString * PICUPLOADURL      =   @"http://demo.top66.net/mobile/";          //图片上传URL
static NSString * PICTHIRDUPLOADURL =   @"http://demo.top66.net/mobile/";    //第三方场地图片上传

static NSString * PICDOWNLADURL     =   @"http://demo.top66.net/mobile/";         //图片下载URL
#endif

/**
 * 支付宝字串
 */
#define kAlixUrlHost        @"safepay"
#define kAppUrlIdentifier   @"com.ylw"
#define kAppUrlScheme       @"com.ylw.scheme"
// 错误
#define kErrorCodeKey       @"ErrorCodeKey"
#define kCustomErrorDomain  @"com.ylw.client"
// 支付宝
#define kECodeAlixPayFail  101
/*
 * 常量字符串
 */

// 通知 常量字符串
#define kNotificationGetUserLocation           @"kNotificationGetUserLocation"//得到用户地址通知

/*
 * 视图间距固定变量
 */
#define PIXEL_2     2.f
#define PIXEL_4     4.f
#define PIXEL_8     8.f
#define PIXEL_12    12.f
#define PIXEL_16    16.f

/*
 * 枚举值
 */
typedef NS_ENUM(NSInteger, respCode) {
    // 用户类型
     kSER_ERROR         = -1,   //未知服务端错误
     kFAIL              = 0,     //失败代码
     kSUCCESS           = 1,    //成功代码
     kTOKEN_INVALID     = 2,    //token 失效
     kMSG_SEND_FAIL     = 3,    // 短信消息发送失败
     kOPERATE_MORE      = 9,    //您操作太频繁了,请稍后重试.
};
typedef NS_ENUM(NSUInteger, StoreStatus) {

    //0审核中,1审核通过不可下单,2审核通过可下单,3禁用,4删除
    kSTORE_AUDIT_STATUS_ING                = 0, //审核中
    kSTORE_AUDIT_STATUS_UN_ORDER           = 1, //审核通过,不能下单
    kSTORE_AUDIT_STATUS_ORDER              = 2, //审核通过,可下单
    kSTORE_AUDIT_STATUS_DISABLED           = 3, //禁用
    kSTORE_AUDIT_STATUS_DEL                = 4, //已删除
};
/*
 * 登录类型
 */
typedef NS_ENUM(NSInteger, enterType) {
    kPlatformType,
    kQQType,
    kWeChatType,
    kSinatype,
};


/*
 * Block 预定义
 */
typedef void(^Block)(void);
typedef void(^BlockBlock)(Block block);
typedef void(^BOOLBlock)(BOOL b);
typedef void(^ObjectBlock)(id obj);
typedef void(^ArrayBlock)(NSArray *array);
typedef void(^MutableArrayBlock)(NSMutableArray *array);
typedef void(^DictionaryBlock)(NSDictionary *dic);
typedef void(^ErrorBlock)(NSError *error);
typedef void(^IndexBlock)(NSInteger index);
typedef void(^FloatBlock)(CGFloat afloat);
typedef void(^StringBlock)(NSString *str);

typedef void(^CancelBlock)(id viewController);
typedef void(^FinishedBlock)(id viewController, id object);


#endif
