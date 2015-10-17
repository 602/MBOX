//
//  HotVC.m
//  myProject
//
//  Created by Charles_Wl on 15/8/9.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "HotVC.h"
#import "HotCell.h"
@interface HotVC ()
@property (strong, nonatomic) IBOutlet UITableView *hotTableView;
@property (strong, nonatomic) IBOutlet UIView *hotView;

@end

@implementation HotVC
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
        self.tabBarItem.title = @"排行";
        self.tabBarItem.image = [UIImage imageNamed:@"number_disselected"];
        self.tabBarItem.selectedImage = [[UIImage imageNamed:@"number_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"排行";
    self.hotTableView.tableHeaderView = self.hotView;
    self.hotTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UINib* nib = [UINib nibWithNibName:@"HotCell" bundle:nil];
    [self.hotTableView registerNib:nib forCellReuseIdentifier:hotCellIdentifier];
    self.hotTableView.dataSource = self;
    self.hotTableView.delegate = self;
}

#pragma mark - UITableViewDatasourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HotCell *cell = [tableView dequeueReusableCellWithIdentifier:hotCellIdentifier forIndexPath:indexPath];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:{
            cell.headIV.image = [UIImage imageNamed:@"gold"];
        }
            break;
            
        case 1:{
            cell.headIV.image = [UIImage imageNamed:@"silver"];
        }
            break;
        case 2:{
            cell.headIV.image = [UIImage imageNamed:@"copper"];
        }
            break;
    }
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return /*[MenuCell cellHeight]*/60;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
