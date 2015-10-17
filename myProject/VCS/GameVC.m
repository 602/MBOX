//
//  GameVC.m
//  myProject
//
//  Created by charles on 15/7/29.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "GameVC.h"

@interface GameVC ()

@end

@implementation GameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"应用名称";
}
- (IBAction)doneAppSelf:(UIButton *)sender {
    QQLog(@"自己下载");
}

- (IBAction)shareOtherAction:(UIButton *)sender {
    QQLog(@"邀请好友下载");
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
