//
//  TestTempVCFor_WangTao.m
//  QQing
//
//  Created by Ben on 6/10/15.
//  Copyright (c) 2014 QQing. All rights reserved.
//

#import "TestTempVCFor_WangTao.h"
#import "TestUtil.h"

@interface TestTempVCFor_WangTao ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *DataArray;
@end

@implementation TestTempVCFor_WangTao

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.DataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.DataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (NSArray *)DataArray {

    if (!_DataArray) {
        _DataArray = @[@"城市选择"];
    }
    return _DataArray;
}

#pragma mark - 支付demo
- (void)payDemo {

    //TODO:WT发送支付请求，返回partner，seller，key，returnURL，subject。这些数据也可以保存的本地，就不需要请求
    /*[NetworkApi deliverRequest:request
                       success:^(NSMutableArray *array) {
                           [hud hide:YES];
                           
                           UserPayResult *res = [array lastObject];
                           
                           switch (res.result) {
                                   
                               case kPayBalanceSuccess: {
                                   AlipayEncode *enc = [[AlipayEncode alloc] init];
                                   [enc setParameters:res.partner
                                               seller:res.seller
                                                  key:res.key];
                                   
#if __DEBUG_VERSION // 测服
                                   NSString *orderidEx = [NSString stringWithFormat:@"%lld-test", self.orderInfo.ID];
                                   ailiPay_Price = 0.1;
#else
                                   NSString *orderidEx = [NSString stringWithFormat:@"%lld", self.orderInfo.ID];
#endif
                                   
                                   NSString *orderinfo = [enc encode:orderidEx
                                                             subject:res.name
                                                                body:res.name
                                                               price:[NSString stringWithFormat:@"%.02f", ailiPay_Price]
                                                           validDate:[[NSDate dateFromLongLong:res.validDate] dateOfStringWithFormat:@"yyyy-MM-dd HH:mm:ss"]
                                                           notifyUrl:res.returnUrl
                                                           returnUrl:@""];
                                   
                                   QQLog(@"%@", orderinfo);
                                   
                                   [[PaymentService sharedPaymentService] payOrder:orderinfo
                                                                            scheme:kAppUrlScheme
                                                                           success:^{
                                                                               [hud hide:YES];
                                                                               
                                                                               [Utils showToastWithText:@"支付成功！" isLoading:NO isBottom:NO];
                                                                               
                                                                               // 结束当前页面
                                                                               [self doReturn];
                                                                               
                                                                               // 通知前方ViewController
                                                                               if (self.success) {
                                                                                   self.success();
                                                                               }
                                                                               
                                                                               // fixme: 如果是立即体验，这个通知没人处理
                                                                               // 付款成功，发出全局通知
                                                                               [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationRefreshCouseF5 object:nil];
                                                                               
                                                                               [Utils showToastWithText:@"支付成功" isLoading:NO isBottom:NO];
                                                                           } cancel:^{
                                                                               [hud hide:YES];
                                                                               
                                                                               [Utils showToastWithText:@"支付取消" isLoading:NO isBottom:NO];
                                                                               
                                                                               if (self.cancel) {
                                                                                   self.cancel();
                                                                               }
                                                                           } failure:^(NSError *error) {
                                                                               [hud hide:YES];
                                                                               
                                                                               if (error) {
                                                                                   NSDictionary *result = [error userInfo];
                                                                                   [Utils showToastWithText:[result objectForKey:kPaymentServiceEcodeDescKey] isLoading:NO isBottom:NO];
                                                                               }
                                                                           }];
                               }
                                   break;
                           }
                       } failure:^(NSError *error) {
                           [hud hide:YES];
                           
                           [Utils showToastWithText:@"支付失败" isLoading:NO isBottom:NO];
                       }];
     */

}
@end
