//
//  CheckVC.m
//  com.icetang.www
//
//  Created by Charles_Wl on 15/9/22.
//  Copyright © 2015年 王涛. All rights reserved.
//

#import "CheckVC.h"
#import "CheckCell.h"
@interface CheckVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *checkTV;

@end

@implementation CheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收益明细";
    
    /**
     *  添加推广页
     */
    UINib* nib = [UINib nibWithNibName:@"CheckCell" bundle:nil];
    [self.checkTV registerNib:nib forCellReuseIdentifier:checkCellIdentifier];
    self.checkTV.dataSource = self;
    self.checkTV.delegate = self;
}

#pragma mark - UITableViewDatasourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckCell *cell = [tableView dequeueReusableCellWithIdentifier:checkCellIdentifier forIndexPath:indexPath];
//    cell.model = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return /*[MenuCell cellHeight]*/90;
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
