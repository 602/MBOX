//
//  TestViewControllerHome.m
//  QQing
//
//  Created by Ben on 6/10/15.
//  Copyright (c) 2014 QQing. All rights reserved.
//

#import "TestViewControllerHome.h"
#import "TestShowDebugViewController.h"
#import "TestTempVCFor_LiJie.h"
#import "TestTempVCFor_AnBo.h"
#import "TestTempVCFor_TaoCheng.h"
#import "TestTempVCFor_WangTao.h"
#import "TestTempVCFor_XieXiaoFeng.h"
#import "TestTempVCFor_GuoXiaoQian.h"
#import "TestTempVCFor_XiaXuQiang.h"

static const CGFloat kTableViewCellHeight = 40.0f;

@interface TestTableViewCellModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSValue *action;

@end

@implementation TestTableViewCellModel

@end


@interface TestViewControllerHome () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

@implementation TestViewControllerHome

#pragma mark - View Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"测试页面";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    TestTableViewCellModel *item1 = [[TestTableViewCellModel alloc] init];
    item1.title = @"临时日志记录";
    item1.action = [NSValue valueWithPointer:@selector(showDebugLogAction:)];
    
    TestTableViewCellModel *item2 = [[TestTableViewCellModel alloc] init];
    item2.title = @"王涛1的测试页面";
    item2.action = [NSValue valueWithPointer:@selector(showLiJieTestAction:)];
    
    TestTableViewCellModel *item3 = [[TestTableViewCellModel alloc] init];
    item3.title = @"王涛2的测试页面";
    item3.action = [NSValue valueWithPointer:@selector(showAnBoTestAction:)];
    
    TestTableViewCellModel *item4 = [[TestTableViewCellModel alloc] init];
    item4.title = @"王涛3的测试页面";
    item4.action = [NSValue valueWithPointer:@selector(showTaoChengTestAction:)];
    
    TestTableViewCellModel *item5 = [[TestTableViewCellModel alloc] init];
    item5.title = @"王涛4的测试页面";
    item5.action = [NSValue valueWithPointer:@selector(showWangTaoTestAction:)];
    
    TestTableViewCellModel *item6 = [[TestTableViewCellModel alloc] init];
    item6.title = @"王涛5的测试页面";
    item6.action = [NSValue valueWithPointer:@selector(showXieXiaoFengTestAction:)];
    
    TestTableViewCellModel *item7 = [[TestTableViewCellModel alloc] init];
    item7.title = @"王涛6的测试页面";
    item7.action = [NSValue valueWithPointer:@selector(showGuoXiaoQianTestAction:)];
    
    TestTableViewCellModel *item8 = [[TestTableViewCellModel alloc] init];
    item8.title = @"王涛7的测试页面";
    item8.action = [NSValue valueWithPointer:@selector(showXiaXuQiangTestAction:)];
    
    self.dataSourceArray = [NSMutableArray arrayWithObjects:item1, item2, item3, item4, item5, item6, item7, item8, nil];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)showDebugLogAction:(NSString *)title
{
    TestShowDebugViewController *testDebugVC = [[TestShowDebugViewController alloc] init];
    testDebugVC.title = title;
    
    [self.navigationController pushViewController:testDebugVC animated:YES];
}

- (void)showLiJieTestAction:(NSString *)title
{
    TestTempVCFor_LiJie *testDebugVC = [[TestTempVCFor_LiJie alloc] init];
    testDebugVC.title = title;
    
    [self.navigationController pushViewController:testDebugVC animated:YES];
}

- (void)showAnBoTestAction:(NSString *)title
{
    TestTempVCFor_AnBo *testDebugVC = [[TestTempVCFor_AnBo alloc] init];
    testDebugVC.title = title;
    
    [self.navigationController pushViewController:testDebugVC animated:YES];
}

- (void)showTaoChengTestAction:(NSString *)title
{
    TestTempVCFor_TaoCheng *testDebugVC = [[TestTempVCFor_TaoCheng alloc] init];
    testDebugVC.title = title;
    
    [self.navigationController pushViewController:testDebugVC animated:YES];
}

- (void)showWangTaoTestAction:(NSString *)title
{
    TestTempVCFor_WangTao *testDebugVC = [[TestTempVCFor_WangTao alloc] init];
    testDebugVC.title = title;
    
    [self.navigationController pushViewController:testDebugVC animated:YES];
}

- (void)showXieXiaoFengTestAction:(NSString *)title
{
    TestTempVCFor_XieXiaoFeng *testDebugVC = [[TestTempVCFor_XieXiaoFeng alloc] init];
    testDebugVC.title = title;
    
    [self.navigationController pushViewController:testDebugVC animated:YES];
}

- (void)showGuoXiaoQianTestAction:(NSString *)title
{
    TestTempVCFor_GuoXiaoQian *testDebugVC = [[TestTempVCFor_GuoXiaoQian alloc] init];
    testDebugVC.title = title;
    
    [self.navigationController pushViewController:testDebugVC animated:YES];
}

- (void)showXiaXuQiangTestAction:(NSString *)title
{
    TestTempVCFor_XiaXuQiang *testDebugVC = [[TestTempVCFor_XiaXuQiang alloc] init];
    testDebugVC.title = title;
    
    [self.navigationController pushViewController:testDebugVC animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellReuseIdentifier = @"TestTableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, [UIUtils screenWidth], kTableViewCellHeight)];
    }
    
    cell.textLabel.textColor = [UIColor themeBlueColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    cell.textLabel.text = ((TestTableViewCellModel *)[self.dataSourceArray objectAtIndexIfIndexInBounds:indexPath.row]).title;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kTableViewCellHeight;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SEL selector = [((TestTableViewCellModel *)[self.dataSourceArray objectAtIndexIfIndexInBounds:indexPath.row]).action pointerValue];
    if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:selector withObject:((TestTableViewCellModel *)[self.dataSourceArray objectAtIndexIfIndexInBounds:indexPath.row]).title];
#pragma clang diagnostic pop
    }
}

@end
