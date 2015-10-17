//
//  MUserModel.h
//  myProject
//
//  Created by Charles_Wl on 15/10/6.
//  Copyright © 2015年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUserModel : NSObject

+ (instancetype)sharedMUserModel;

//友盟唯一绑定
@property (strong, nonatomic) NSString *appPushToken;
//返回结果
@property (strong, nonatomic) NSString *resultMsg;
//返回结果值 200 成功  400 失败
@property (nonatomic)NSInteger statusCode;
//tokenID
@property (strong, nonatomic) NSString *tokenId;
//用户index
@property (nonatomic) NSInteger userIndex;
//用户小头像路径
@property (nonatomic, strong) NSString *userSmallHeadImgUrl;

@property (nonatomic, strong) NSString *appVersion;

@property (nonatomic, strong) NSString *inviteCode;

@property (nonatomic, strong) NSString *userAddress;

@property (nonatomic, strong) NSString *userBigHeadImgUrl;

@property (nonatomic, assign) float userSmallImgHeight;

@property (nonatomic, assign) float userSmallImgWidth;

@property (nonatomic, assign) float userBigImgHeight;

@property (nonatomic, assign) float userBigImgWidth;

@property (nonatomic, strong) NSString *userCity;

@property (nonatomic, strong) NSString *userMail;

@property (nonatomic, strong) NSString *userNick;

@property (nonatomic, strong) NSString *userPhone;

@property (nonatomic, strong) NSString *userPhoneVersion;

@property (nonatomic, strong) NSString *userProfession;

@property (nonatomic, strong) NSString *userSex;

@property (nonatomic, strong) NSString *userSignContext;

@property (nonatomic, strong) NSString *userStatus;

@property (nonatomic, strong) NSString *userBirthday;





@end
