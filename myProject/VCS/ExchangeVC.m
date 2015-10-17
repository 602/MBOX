//
//  ExchangeVC.m
//  myProject
//
//  Created by Charles_Wl on 15/8/9.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "ExchangeVC.h"
#import "ExChangeCell.h"
#import "QqVC.h"
#import "AlipayVC.h"
#import "phoneNumberVC.h"
#import "changeTVC.h"
@interface ExchangeVC ()
@property (strong, nonatomic) IBOutlet UITableView *exChangeTV;
@property (strong, nonatomic) IBOutlet UIView *headChangeView;
@end

@implementation ExchangeVC
#pragma mark - Life cycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"兑换";
        self.tabBarItem.image = [UIImage imageNamed:@"exchange_disselected"];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"exchange_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"兑换";
    self.exChangeTV.tableHeaderView = self.headChangeView;
    self.exChangeTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib* nib = [UINib nibWithNibName:@"ExChangeCell" bundle:nil];
    [self.exChangeTV registerNib:nib forCellReuseIdentifier:exChangeCellIdentifier];
    self.exChangeTV.dataSource = self;
    self.exChangeTV.delegate = self;
}

#pragma mark - ActionResponce

- (IBAction)didClickOnChangeButton:(UIButton *)sender {
    changeTVC *changeTvc = [[changeTVC alloc]_initWithNib];
    changeTvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:changeTvc animated:YES];
}

#pragma mark - UITableViewDatasourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:exChangeCellIdentifier forIndexPath:indexPath];
    cell.headIV.layer.masksToBounds =YES;
    cell.headIV.layer.cornerRadius =25;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 1) {
        cell.titleLabel.text = @"支付宝充值";
        cell.middleLabel.text = @"10余额";
        cell.contentLabel.text = @"充值到支付宝账户余额";
        cell.headIV.image = [UIImage imageNamed:@"alipay"];
    }else if(indexPath.row == 2){
        cell.titleLabel.text = @"手机话费";
        cell.middleLabel.text = @"10余额";
        cell.contentLabel.text = @"支持全国各地话费兑换";
        cell.headIV.image = [UIImage imageNamed:@"phone"];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return /*[MenuCell cellHeight]*/60;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            QqVC* qqvc = [[QqVC alloc]_initWithNib];
            qqvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:qqvc animated:YES];
        }
            break;
            
        case 1:{
            AlipayVC* alivc = [[AlipayVC alloc]_initWithNib];
            alivc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:alivc animated:YES];
        }
            
            break;
            
        case 2:{
            phoneNumberVC* phoneNumVc = [[phoneNumberVC alloc]_initWithNib];
            phoneNumVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:phoneNumVc animated:YES];
        }
            
            break;
    }
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
