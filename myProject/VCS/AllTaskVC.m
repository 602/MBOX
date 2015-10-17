//
//  AllTaskVC.m
//  myProject
//
//  Created by Charles_Wl on 15/8/4.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "AllTaskVC.h"
#import "AllTaskCell.h"
#import "MenuCell.h"
#import "MenuListModel.h"
#import "PublicVC.h"
#import "ShareVC.h"
#import "GameVC.h"
#import "NetWorkApi.h"

#import "MUserModel.h"
#import "MTaskListModel.h"

@interface AllTaskVC ()
@property (weak, nonatomic) IBOutlet UITableView *allTaskTableView;
@property (strong, nonatomic) NSArray *dataArr;
@property (strong, nonatomic) MUserModel *mUserModel;
@property (strong, nonatomic) MTaskListModel *taskListModel;
@property (strong, nonatomic) NSString *pageNo;
@property (strong, nonatomic) NSString *pageSize;
@property (strong, nonatomic) NSString *tokenId;
@end

@implementation AllTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"限时推荐";
    self.allTaskTableView.dataSource = self;
    self.allTaskTableView.delegate = self;
    UINib* nib = [UINib nibWithNibName:@"AllTaskCell" bundle:nil];
    [self.allTaskTableView registerNib:nib forCellReuseIdentifier:taskCellIdentifier];
    
    //请求数据
    [self getNetTaskList];
}

/**
 *请求方法
 */
- (void)getNetTaskList {
    self.pageNo = @"1";
    self.pageSize = @"10";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.tokenId = [userDefaults stringForKey:@"tokenId"];
    QQLog(@"多少:%@",self.tokenId);
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[self.pageNo,self.pageSize,self.tokenId] forKeys:@[@"pageNo",@"pageSize",@"tokenId"]];
    [[NetWorkApi sharedNetWorkApi] getAllTaskList:dic success:^(id obj) {
        QQLog(@"限时推荐: %@",obj);
        self.taskListModel = obj;
        self.dataArr = self.taskListModel.list;
        QQLog(@"多少列表:%ld",self.dataArr.count);
        [self.allTaskTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - UITableViewDatasourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
        if (indexPath.row == 0) {
            PublicVC* Pvc = [[PublicVC alloc]initWithNibName:@"PublicVC" bundle:nil];
            [self.navigationController pushViewController:Pvc animated:YES];
        }else if (indexPath.row == 1){
            ShareVC* Svc = [[ShareVC alloc]initWithNibName:@"ShareVC" bundle:nil];
            [self.navigationController pushViewController:Svc animated:YES];
        }else{
            GameVC* Gvc = [[GameVC alloc]initWithNibName:@"GameVC" bundle:nil];
            [self.navigationController pushViewController:Gvc animated:YES];
        }
    
    
}


#pragma mark - Getters and Setters
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

@end
