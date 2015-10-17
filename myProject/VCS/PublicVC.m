//
//  PublicVC.m
//  myProject
//
//  Created by charles on 15/7/28.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "PublicVC.h"

@interface PublicVC ()

@end

@implementation PublicVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"公众号";
}


#pragma buttonEvent
- (IBAction)mySelfAction:(UIButton *)sender {
    QQLog(@"个人关注");
}

- (IBAction)otherAction:(UIButton *)sender {
    QQLog(@"邀请好有关注");
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
