//
//  NetWorkApi.h
//  myProject
//
//  Created by Apple on 15/5/31.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络请求的唯一入口，其他功能封装起来
 */
@interface NetWorkApi : NSObject
+ (NetWorkApi *)sharedNetWorkApi;
//============================所有接口入口==========================

//登录入口
- (void)enterInMoneyHome:(NSDictionary *)param success:(ObjectBlock)success failure:(ErrorBlock)failure;


//钱家手机获取验证码
-(void)getPhoneVerification:(NSDictionary *)param success:(ObjectBlock)success failure:(ErrorBlock)failure;


//测试钱家注册接口
- (void)registerMoneyInfo:(NSDictionary *)param success:(ObjectBlock)success failure:(ErrorBlock)failure;


//获取限时推荐列表
- (void)getAllTaskList:(NSDictionary *)param success:(ObjectBlock)success failure:(ErrorBlock)failure;

//收益
- (void)getUserMoneyListWithSuccess:(ObjectBlock)success failure:(ErrorBlock)failure;


//注销
- (void)cancelAppWithsuccess:(ObjectBlock)success failure:(ErrorBlock)failure;

//修改个人信息
- (void)updateUserInfo:(NSDictionary *)param success:(ObjectBlock)success failure:(ErrorBlock)failure;


@end
