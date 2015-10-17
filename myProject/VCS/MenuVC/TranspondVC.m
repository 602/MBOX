//
//  TranspondVC.m
//  myProject
//
//  Created by 顾欢欢 on 15/8/16.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "TranspondVC.h"
#import "TranspondCell.h"
#import "AllTaskCell.h"
@interface TranspondVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TranspondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"有偿转发";
    self.transPondTableView.dataSource = self;
    self.transPondTableView.delegate = self;
    UINib* nib = [UINib nibWithNibName:@"AllTaskCell" bundle:nil];
    [self.transPondTableView registerNib:nib forCellReuseIdentifier:taskCellIdentifier];
}

#pragma mark - UITableViewDatasourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AllTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:taskCellIdentifier forIndexPath:indexPath];
    //        if (!cell) {
    //            cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCellIdentifier];
    //        }
    //cell.model = self.dataArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return /*[MenuCell cellHeight]*/80;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.row == 0) {
//        PublicVC* Pvc = [[PublicVC alloc]initWithNibName:@"PublicVC" bundle:nil];
//        [self.navigationController pushViewController:Pvc animated:YES];
//    }else if (indexPath.row == 1){
//        ShareVC* Svc = [[ShareVC alloc]initWithNibName:@"ShareVC" bundle:nil];
//        [self.navigationController pushViewController:Svc animated:YES];
//    }else{
//        GameVC* Gvc = [[GameVC alloc]initWithNibName:@"GameVC" bundle:nil];
//        [self.navigationController pushViewController:Gvc animated:YES];
//    }
    
    
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
