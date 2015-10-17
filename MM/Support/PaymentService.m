//
//  AlipayService.m
//  QQing
//
//  Created by 李杰 on 2/28/15.
//
//

#import <AlipaySDK/AlipaySDK.h>

#import "PaymentService.h"
#import "Order.h"
#import "DataSigner.h"
#import "DataVerifier.h"

@implementation PaymentService
@synthesize payResult;
@synthesize success;
@synthesize failure;

SINGLETON_GCD(PaymentService);

- (void)powerOn {
    payResult = [NSMutableDictionary new];
    
    // kNotificationAlixResult??
}

- (void)powerOff {
    payResult = nil;
}

- (void)payOrder:(NSString *)order
          scheme:(NSString *)scheme
         success:(Block)success_
          cancel:(Block)cancel_
         failure:(ErrorBlock)failure_ {
    self.success = success_;
    self.failure = failure_;
    self.cancel = cancel_;
    
#ifdef DEBUG
//    [[AlipaySDK defaultService] setUrl:@"https://openapi.alipaydev.com/gateway.do"];
#endif
    [[AlipaySDK defaultService] payOrder:order
                              fromScheme:scheme
                                callback:^(NSDictionary *resultDic) {
                                    NSLog(@"reslut = %@",resultDic);
                                    
                                    NSString *memo = [resultDic objectForKey:@"memo"];
                                    NSString *result = [resultDic objectForKey:@"result"];
                                    NSNumber *status = [resultDic objectForKey:@"resultStatus"];
                                    
                                    (void)memo;
                                    (void)result;
                                    
                                    [payResult removeAllObjects];
                                    
#define aliServiceSucceed   9000
#define aliServiceDealing   8000
#define aliServiceFailed    4000
#define aliServiceCancel    6001
#define aliServiceNetErr    6002
                                    
                                    switch ([status intValue]) {
                                        case aliServiceSucceed: {
                                            if (self.success) {
                                                self.success();
                                            }
                                        }
                                            break;
                                            
                                        case aliServiceDealing: {
                                            if (self.failure) {
                                                [payResult setObject:kPaymentServiceEcodeDescKey forKey:@"支付订单正在处理中"];
                                                
                                                self.failure([NSError errorWithDomain:kErrorCodeKey code:kECodeAlixPayFail userInfo:payResult]);
                                            }
                                        }
                                            break;
                                            
                                        case aliServiceFailed: {
                                            if (self.failure) {
                                                [payResult setObject:@"支付失败" forKey:kPaymentServiceEcodeDescKey];
                                                
                                                self.failure([NSError errorWithDomain:kErrorCodeKey code:kECodeAlixPayFail userInfo:payResult]);
                                            }
                                        }
                                            break;
                                            
                                        case aliServiceCancel: {
                                            if (self.cancel) {
                                                [payResult setObject:@"支付订单被取消" forKey:kPaymentServiceEcodeDescKey];
                                                
                                                self.cancel();
                                            }
                                        }
                                            break;
                                            
                                        case aliServiceNetErr: {
                                            if (self.failure) {
                                                [payResult setObject:@"网络连接失败" forKey:kPaymentServiceEcodeDescKey];
                                                
                                                self.failure([NSError errorWithDomain:kErrorCodeKey code:kECodeAlixPayFail userInfo:payResult]);
                                            }
                                        }
                                            
                                        default: {
                                            if (self.failure) {
                                                self.failure([NSError errorWithDomain:kErrorCodeKey code:kECodeAlixPayFail userInfo:resultDic]);
                                            }
                                        }
                                            break;
                                    }
                                    
                                    
                                }];
}

@end

@implementation AlipayEncode
@synthesize defaultPartner;
@synthesize defaultSeller;
@synthesize privateCode;

- (AlipayEncode *)setParameters:(NSString *)partner seller:(NSString *)seller key:(NSString *)key {
    self.defaultPartner = partner;
    self.defaultSeller = seller;
    self.privateCode = key;
    
    return self;
}

- (NSString *)encode:(NSString *)orderid
             subject:(NSString *)subject
                body:(NSString *)body
               price:(NSString *)price
           validDate:(NSString *)date //
           notifyUrl:(NSString *)notifyUrl
           returnUrl:(NSString *)returnUrl {
    NSString *orderInfo = [self encodeRrderInfo:orderid
                                        subject:subject
                                           body:body
                                          price:price
                                      validDate:date
                                      notifyUrl:notifyUrl
                                      returnUrl:returnUrl];
    NSString *signedInfo = [self doRsa:orderInfo];
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedInfo, @"RSA"];
    return orderString;
}

- (NSString *)encodeRrderInfo:(NSString *)orderid
                      subject:(NSString *)subject
                         body:(NSString *)body
                        price:(NSString *)price
                    validDate:(NSString *)date
                    notifyUrl:(NSString *)notifyUrl
                    returnUrl:(NSString *)returnUrl {
    Order *order = [[Order alloc] init];
    order.partner = self.defaultPartner;
    order.seller = self.defaultSeller;
    
    order.tradeNO = orderid;            //订单ID（由商家自行制定）
    order.productName = subject;        //商品标题
    order.productDescription = body;    //商品描述
    order.amount = price;               // 商品价格
    order.notifyURL = notifyUrl;        // 回调URL
    order.showUrl = @"m.alipay.com";    // returnUrl;
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = [NSString stringWithFormat:@"%@", date]; // 格式yyyy-MM-dd HH:mm:ss（5月26号后）
    // m-分钟，h－小时，d－天，1c－当天，范围：1m－15d （5月26号之前）
    
    return [order description];
}

#pragma mark - Rsa

- (NSString *)doRsa:(NSString *)orderInfo {
    id<DataSigner> signer;
    signer = CreateRSADataSigner(self.privateCode);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

- (NSString *)signType {
    return @"sign_type=\"RSA\"";
}

@end