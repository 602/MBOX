//
//  MenuVC.m
//  myProject
//
//  Created by Apple on 15/5/31.
//  Copyright (c) 2015年 王涛. All rights reserved.
//
/**
 * 使用自动布局解决适配问题。1：Xib ，2：Masonry
 * 1 主页使用XIB举例
 * 2 MenuCell.h 使用Masonry布局，纯代码
 * 3 首页测试页，写的都是示例
 */
#import "MenuVC.h"
#import "HomeCell.h"
#import "MenuCell.h"
#import "MenuListModel.h"
#import "PublicVC.h"
#import "ShareVC.h"
#import "GameVC.h"
#import "AllTaskVC.h"
#import "TranspondVC.h"
#import "NewPlayerVC.h"
#import "PrizeVC.h"
#import "CheckVC.h"
#import "UIImageView+WebCache.h"
@interface MenuVC ()
@property(nonatomic,strong)UIView* backView;
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userIndexLabel;
@property (weak, nonatomic) IBOutlet UILabel *userMoneyLabel;

@property (nonatomic) NSInteger oldOffset;
@end

@implementation MenuVC

#pragma mark - Life cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"赚钱";
        self.tabBarItem.image = [UIImage imageNamed:@"wallet_disselected"];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"wallet_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}
- (void)viewDidLoad  {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"赚钱";
    self.headImageView.layer.masksToBounds =YES;
    self.headImageView.layer.cornerRadius =30;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    /**
     *  添加推广页
     */
    UINib* nib = [UINib nibWithNibName:@"HomeCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:menuCellIdentifier];
    self.tableView.tableHeaderView = self.headBackView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([Cache sharedCache].isAutoLogin) {
        [self autoLoginAction];
    }else {
        [self downLoadData];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private method

- (void)downLoadData {
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[MUserModel sharedMUserModel].userSmallHeadImgUrl] placeholderImage:nil];
    
    self.userIndexLabel.text = [NSString stringWithFormat:@"ID: %ld",[MUserModel sharedMUserModel].userIndex];
}

// 自动登录
- (void)autoLoginAction {
    
    NSDictionary *param = [NSDictionary dictionaryWithObjects:@[[Cache sharedCache].username,[Cache sharedCache].password ,@(1),[AppSystem appVersion],[AppSystem deviceModel],@"IMEI",[AppSystem OSVersion],@(kPlatformType)] forKeys:@[@"userPhone",@"loginPassword",@"device",@"deviceVersion",@"modelModel",@"modelImei",@"applicationVersion",@"thirdAccountType"]];
    __weak typeof(self) weakSelf = self;
    [[NetWorkApi sharedNetWorkApi] enterInMoneyHome:param success:^(id obj) {
        QQLog(@"登录成功: %@",obj);
        MUserModel *mUserModel = obj;
        if (mUserModel.statusCode == 200) {
            //磁盘缓存
            [[Cache sharedCache] setCookie:YES];
            [[Cache sharedCache] setTokenId:mUserModel.tokenId];
            [weakSelf downLoadData];
        }else {
            [Utils showToastWithText:@"网络错误,请重新登录!"];
        }
    } failure:^(NSError *error) {
        QQLog(@"自动登录失败: %@",error);
        [Utils showToastWithText:@"网络错误！"];
    }];
}

#pragma mark - UITableViewDatasourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView  {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return /*[MenuCell cellHeight]*/85;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            AllTaskVC *allTask = [[AllTaskVC alloc]_initWithNib];
            allTask.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:allTask animated:YES];
        }
            break;
        case 1:{
            TranspondVC *transVc = [[TranspondVC alloc]_initWithNib];
            transVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:transVc animated:YES];
        }
            break;
        case 2:{
            NewPlayerVC *newplayerVc = [[NewPlayerVC alloc]_initWithNib];
            newplayerVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:newplayerVc animated:YES];
        }
            break;
        case 3:{
            PrizeVC *prizeVc = [[PrizeVC alloc]_initWithNib];
            prizeVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:prizeVc animated:YES];
        }
            break;
    }
}

- (IBAction)checkAction:(UIButton *)sender {
    CheckVC *checkVc = [[CheckVC alloc]_initWithNib];
    checkVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:checkVc animated:YES];
}

#pragma MartinLiPageScrollViewDelegate

- (void)imgViewDidTouchActionAtIndex:(NSInteger)index inArray:(NSArray *)array {
    NSLog(@"%ld",(long)index);
    PublicVC* Pvc = [[PublicVC alloc]initWithNibName:@"PublicVC" bundle:nil];
    Pvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:Pvc animated:YES];
}

#pragma mark - Getters and Setters

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [MenuCellModel listCellarr];
    }
    return _dataArr;
}

@end
