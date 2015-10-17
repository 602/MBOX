//
//  AlipayService.h
//  QQing
//
//  Created by 李杰 on 2/28/15.
//
//

#import <Foundation/Foundation.h>

#define kPaymentServiceEcodeDescKey @"PaymentServiceEcodeDescKey"

@interface PaymentService : NSObject

+ (PaymentService *)sharedPaymentService;

- (void)powerOn;
- (void)powerOff;

- (void)payOrder:(NSString *)order
          scheme:(NSString *)scheme
         success:(Block)success_
          cancel:(Block)cancel_
         failure:(ErrorBlock)failure_;

@property (nonatomic, strong) NSMutableDictionary *payResult;
@property (nonatomic, strong) Block success;
@property (nonatomic, strong) Block cancel;
@property (nonatomic, strong) ErrorBlock failure; // 如果有错误提示

@end

@interface AlipayEncode : NSObject

/**
 * 设置参数
 * @param partner	合作身份者id
 * @param seller	收款支付宝账号
 * @param _private	商户私钥
 * @return
 */
- (AlipayEncode *)setParameters:(NSString *)partner seller:(NSString *)seller key:(NSString *)key;

- (NSString *)encode:(NSString *)orderid
             subject:(NSString *)subject
                body:(NSString *)body
               price:(NSString *)price
           validDate:(NSString *)date
           notifyUrl:(NSString *)notifyUrl
           returnUrl:(NSString *)returnUrl;

- (NSString *)signType;

/*
 * 合作身份者id，以2088开头的16位纯数字
 */
@property (nonatomic, copy) NSString *defaultPartner;
/*
 * 收款支付宝账号
 */
@property (nonatomic, copy) NSString *defaultSeller;
/**
 * 商户私钥，自助生成
 */
@property (nonatomic, copy) NSString *privateCode;

@end
