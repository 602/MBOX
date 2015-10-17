//
//  LoginVC.m
//  com.icetang.www
//
//  Created by Charles_Wl on 15/9/20.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "LoginVC.h"
#import "FogetVC.h"
#import "RegisterVC.h"
#import "ZZTextField.h"
#import "AppDelegate.h"
#import "MUserModel.h"

#import "UMSocialQQHandler.h"
#import "UMSocial.h"
@interface LoginVC ()
@property (weak, nonatomic) IBOutlet ZZTextField *phoneTF;

@property (weak, nonatomic) IBOutlet ZZTextField *passwordTF;

@end

@implementation LoginVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
//forget密码
- (IBAction)forgetPassword:(UIButton *)sender {
    QQLog(@"忘记密码");
    FogetVC *forgetVc = [[FogetVC alloc]_initWithNib];
    [self.navigationController pushViewController:forgetVc animated:YES];
}
- (IBAction)registerUser:(UIButton *)sender {
    QQLog(@"注册新用户");
    RegisterVC *registerVc = [[RegisterVC alloc]_initWithNib];
    [self.navigationController pushViewController:registerVc animated:YES];
}

- (IBAction)loginButton:(UIButton *)sender {
    [Utils showLoadingView];
    
    NSDictionary *param = [NSDictionary dictionaryWithObjects:@[self.phoneTF.text,self.passwordTF.text ,@(1),[AppSystem appVersion],[AppSystem deviceModel],@"IMEI",[AppSystem OSVersion],@(kPlatformType)] forKeys:@[@"userPhone",@"loginPassword",@"device",@"deviceVersion",@"modelModel",@"modelImei",@"applicationVersion",@"thirdAccountType"]];
    __weak typeof(self) weakSelf = self;
    [[NetWorkApi sharedNetWorkApi] enterInMoneyHome:param success:^(id obj) {
        QQLog(@"登录成功: %@",obj);
//        MUserModel *mUserModel = obj;
        [Utils hideLoadingView];
        if ([MUserModel sharedMUserModel].statusCode == 200) {
            //磁盘缓存
            [[Cache sharedCache] setUsername:weakSelf.phoneTF.text password:weakSelf.passwordTF.text];
            [[Cache sharedCache] setCookie:YES];
            [[Cache sharedCache] setTokenId:[MUserModel sharedMUserModel].tokenId];
            
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [app replaceRootControllerBy:kRootViewControllerTypeMainVC];
            
        }else {
            [Utils showToastWithText:@"用户名或密码错误!"];
        }
            
    } failure:^(NSError *error) {
        QQLog(@"登录失败: %@",error);
        [Utils hideLoadingView];
    }];
    
}

- (IBAction)didClickOnThird:(UIButton *)sender {
    QQLog(@"三方登入: %ld",sender.tag);
    //登入类型
    NSString *enterType;
    switch (sender.tag) {
        case 1:
        {
            //QQ
            [UMSocialQQHandler setQQWithAppId:@"1104839918" appKey:@"ATjBDm3Y71P1aPOF" url:@"http://www.umeng.com/social"];
            enterType = UMShareToQQ;
        }
            break;
            
        case 2:
        {
            
            //微信
            enterType = UMShareToWechatSession;
        }
            break;
            
        case 3:
        {
            //新浪
            enterType = UMShareToSina;
        }
            break;
    }
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:enterType];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:enterType];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }
        
    });
    
    
    
}
@end
