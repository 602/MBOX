//
//  boundVC.m
//  myProject
//
//  Created by charles on 15/8/18.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "boundVC.h"
#import "infoCell.h"
@interface boundVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *boundTV;
@property (strong, nonatomic) IBOutlet UIButton *boundButton;

@end

@implementation boundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定手机";
    self.boundTV.tableFooterView = self.boundButton;
    self.boundTV.delegate = self;
    self.boundTV.dataSource = self;
    UINib* nib = [UINib nibWithNibName:@"infoCell" bundle:nil];
    [self.boundTV registerNib:nib forCellReuseIdentifier:infoCellIdentifier];
    self.boundTV.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableViewDatasourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    infoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellIdentifier forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
        {
            cell.headLabel.text = @"手机号码";
            cell.informationTF.text = @"189****3309";
        }
            break;
            
        case 1:
        {
            cell.headLabel.text = @"短信验证码";
            cell.informationTF.text = @"";
        }
            break;
            
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return /*[MenuCell cellHeight]*/60;
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
