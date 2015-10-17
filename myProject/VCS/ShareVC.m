//
//  ShareVC.m
//  myProject
//
//  Created by charles on 15/7/28.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "ShareVC.h"

@interface ShareVC ()

@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享";
    [self downLoadDataFromNet];
}
- (IBAction)doneAppAction:(UIButton *)sender {
    QQLog(@"自己下载应用");
}
- (IBAction)shareOtherAction:(UIButton *)sender {
    QQLog(@"转发别人下载");
}

- (void)downLoadDataFromNet {
    
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] initWithObjects:@[@"1"] forKeys:@[@"id"]];
    
    [[NetWorkApi sharedNetWorkApi] detailItem:paramDict success:^(id obj) {
        
    } failure:^(NSError *error) {
        
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
