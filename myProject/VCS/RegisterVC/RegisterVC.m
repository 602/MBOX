//
//  RegisterVC.m
//  com.icetang.www
//
//  Created by Charles_Wl on 15/9/20.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "RegisterVC.h"
#import "AppSystem.h"
@interface RegisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *securityTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
}
- (IBAction)didClickOnGetSecurity:(UIButton *)sender {
    //跳转网页方法
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    //获取验证码
    NSDictionary *paramPhone = [NSDictionary dictionaryWithObject:self.phoneTF.text forKey:@"userPhone"];
    [[NetWorkApi sharedNetWorkApi] getPhoneVerification:paramPhone success:^(id obj) {
        QQLog(@"获取验证码：%@",obj);
    } failure:^(NSError *error) {
        QQLog(@"错误");
    }];
}

- (IBAction)didClickOnRegist:(UIButton *)sender {
    NSDictionary *param = [NSDictionary dictionaryWithObjects:@[self.securityTF.text,self.phoneTF.text,self.passwordTF.text ,@(1),[AppSystem appVersion],[AppSystem deviceModel],@"IMEI",[AppSystem OSVersion],self.userNameLabel.text,@(0)] forKeys:@[@"smsCodeKey",@"userPhone",@"loginPassword",@"device",@"deviceVersion",@"model",@"imei",@"applicationVersion",@"userNike",@"thirdType"]];
    [[NetWorkApi sharedNetWorkApi]registerMoneyInfo:param success:^(id obj) {
        QQLog(@"注册:%@",obj);
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        QQLog(@"错误");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
