//
//  MeVC.m
//  myProject
//
//  Created by Apple on 15/5/31.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "MeVC.h"
#import "MeCell.h"
#import "InformationVC.h"
#import "boundVC.h"
#import "SecurityVC.h"

#import "AppDelegate.h"

@interface MeVC ()
@property(nonatomic,strong)NSArray* nameArray;
@property (strong, nonatomic) IBOutlet UITableView *meTableView;
@property (strong, nonatomic) IBOutlet UIView *meView;
@property (strong, nonatomic) IBOutlet UIImageView *mySelfIV;
@end

@implementation MeVC
#pragma mark - Life cycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"个人";
        self.tabBarItem.image = [UIImage imageNamed:@"me_disselected"];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"me_selected"]
                                         imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"个人";
    self.mySelfIV.layer.masksToBounds =YES;
    self.mySelfIV.layer.cornerRadius =30;
    self.meTableView.tableHeaderView = self.meView;
    self.meTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib* nib = [UINib nibWithNibName:@"MeCell" bundle:nil];
    [self.meTableView registerNib:nib forCellReuseIdentifier:meCellIdentifier];
    self.meTableView.dataSource = self;
    self.meTableView.delegate = self;
    UIButton *cancelBT = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    [cancelBT setTitle:@"注            销" forState:UIControlStateNormal];
    [cancelBT addTarget:self action:@selector(didClickOnCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    self.meTableView.tableFooterView = cancelBT;
}

#pragma mark - EventResponce

- (void)didClickOnCancelButton:(UIButton *)btn {
    [[NetWorkApi sharedNetWorkApi]cancelAppWithsuccess:^(id obj) {
        [[Cache sharedCache] resetUser];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app replaceRootControllerBy:kRootViewControllerTypeLoginVC];
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)viewDidDisappear:(BOOL)animated {
    //self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDatasourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeCell *cell = [tableView dequeueReusableCellWithIdentifier:meCellIdentifier forIndexPath:indexPath];
    cell.nameCell.text = self.nameArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return /*[MenuCell cellHeight]*/44;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            InformationVC *informationVc = [[InformationVC alloc]_initWithNib];
            informationVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:informationVc animated:YES];
        }
            break;
            
        case 1:
        {
            boundVC *boundVc = [[boundVC alloc]_initWithNib];
            boundVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:boundVc animated:YES];
        }
            break;
        case 2:
        {
            InformationVC *informationVc = [[InformationVC alloc]_initWithNib];
            informationVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:informationVc animated:YES];
        }
            break;
        case 3:
        {
            SecurityVC *securityVc = [[SecurityVC alloc]_initWithNib];
            securityVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:securityVc animated:YES];
        }
            break;
    }

}

#pragma mark - Getters and Setters
- (NSArray *)nameArray {
    if (!_nameArray) {
        _nameArray = @[@"个人资料",@"手机号码",@"联系我们",@"M+码"];
    }
    return _nameArray;
}

@end
