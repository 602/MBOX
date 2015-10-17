//
//  NetWorkApi.m
//  myProject
//
//  Created by Apple on 15/5/31.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "NetWorkApi.h"
#import "MUserModel.h"
@implementation NetWorkApi

SINGLETON_GCD(NetWorkApi);
#pragma mark - Private method
//Money+登录入口
- (void)enterInMoneyHome:(NSDictionary *)param success:(ObjectBlock)success failure:(ErrorBlock)failure {
    [[NetWorkRequest sharedNetWorkRequest] AFPostByApiName:@"user/login" Params:param success:^(id obj) {
        QQLog(@"登录成功：%@",obj);
        MUserModel *mUserModel = [MMJsonParse parseMUserModel:obj];
        success(mUserModel);
    } failure:^(NSError *error) {
        QQLog(@"登录失败：%@",error);
    }];
}

//钱家
- (void)getPhoneVerification:(NSDictionary *)param success:(ObjectBlock)success failure:(ErrorBlock)failure {
    [[NetWorkRequest sharedNetWorkRequest] AFPostByApiName:@"user/getRegistSecurityCode" Params:param success:^(id obj) {
        QQLog(@"验证码：%@",obj);
        success(obj);
    } failure:^(NSError *error) {
        QQLog(@"验证码：%@",error);
        failure(error);
    }];
}

//注册
- (void)registerMoneyInfo:(NSDictionary *)param success:(ObjectBlock)success failure:(ErrorBlock)failure {
    [[NetWorkRequest sharedNetWorkRequest]AFPostByApiName:@"user/register" Params:param success:^(id obj) {
        QQLog(@"注册：%@",obj);
        success(obj);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//获取限时推荐列表
- (void)getAllTaskList:(NSDictionary *)param success:(ObjectBlock)success failure:(ErrorBlock)failure {
    [[NetWorkRequest sharedNetWorkRequest] AFPostByApiName:@"/task/recommend/getPage" Params:param success:^(id obj) {
        QQLog(@"限时推荐列表：%@",obj);
        MTaskListModel *taskListModel = [MMJsonParse parseMTaskListModel:obj];
        success(taskListModel);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end