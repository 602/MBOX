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

//收益
- (void)getUserMoneyListWithSuccess:(ObjectBlock)success failure:(ErrorBlock)failure {
    NSDictionary *param = [NSDictionary dictionaryWithObjects:@[[Cache sharedCache].tokenId] forKeys:@[@"tokenId"]];
    
    [[NetWorkRequest sharedNetWorkRequest]AFPostByApiName:@"/profit/getUserProfit" Params:param success:^(id obj) {
        QQLog(@"啦啦啦: %@",obj);
        success (obj);
    } failure:^(NSError *error) {
        QQLog(@"失败: %@",error);
        failure (error);
    }];
}

//注销
- (void)cancelAppWithsuccess:(ObjectBlock)success failure:(ErrorBlock)failure {
    QQLog(@"tokenId: %@",[Cache sharedCache].tokenId);
    NSDictionary *param = [NSDictionary dictionaryWithObjects:@[[Cache sharedCache].tokenId] forKeys:@[@"tokenId"]];
    [[NetWorkRequest sharedNetWorkRequest]AFPostByApiName:@"user/logout" Params:param success:^(id obj) {
        QQLog(@"注销: %@",obj);
        success (obj);
    } failure:^(NSError *error) {
        failure (error);
    }];
}

//修改个人信息
- (void)updateUserInfo:(id)param success:(ObjectBlock)success failure:(ErrorBlock)failure {
    
//    [[NetWorkRequest sharedNetWorkRequest] AFPostMultipartFormByApiName:@"user/updateUserBasic" Params:param success:^(id obj) {
//        QQLog(@"修改个人信息：%@",obj);
//        MUserModel *mUserModel = [MMJsonParse parseMUserModel:obj];
//        success(mUserModel);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
    
    [[NetWorkRequest sharedNetWorkRequest] postByApiName:@"user/updateUserBasic" Params:param success:^(id obj) {
        QQLog(@"修改个人信息：%@",obj);
        MUserModel *mUserModel = [MMJsonParse parseMUserModel:obj];
        success(mUserModel);
    } failure:^(NSError *error) {
        failure(error);

    }];
}

//限时分享详情
- (void)detailItem:(id)param success:(ObjectBlock)success failure:(ErrorBlock)failure {
    [[NetWorkRequest sharedNetWorkRequest] AFPostByApiName:@"/task/recommend/getDetail" Params:param success:^(id obj) {
        QQLog(@"限时推荐详情：%@",obj);
        
        success(nil);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
