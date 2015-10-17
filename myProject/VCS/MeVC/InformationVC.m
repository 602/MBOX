//
//  InformationVC.m
//  myProject
//
//  Created by Charles_Wl on 15/8/17.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "InformationVC.h"
#import "infoCell.h"
@interface InformationVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *infoTV;
@property (strong, nonatomic) IBOutlet UIView *infoHV;
@property (strong, nonatomic) IBOutlet UIButton *commitButton;

@end

@implementation InformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.infoTV.tableHeaderView = self.infoHV;
    self.infoTV.tableFooterView = self.commitButton;
    self.infoTV.delegate = self;
    self.infoTV.dataSource = self;
    UINib* nib = [UINib nibWithNibName:@"infoCell" bundle:nil];
    [self.infoTV registerNib:nib forCellReuseIdentifier:infoCellIdentifier];
    self.infoTV.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableViewDatasourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    infoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellIdentifier forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
        {
            cell.headLabel.text = @"昵称";
            cell.informationTF.text = @"颜斌斌";
        }
            break;
            
        case 1:
        {
            cell.headLabel.text = @"性别";
            cell.informationTF.text = @"男";
        }
            break;
        case 2:
        {
            cell.headLabel.text = @"生日";
            cell.informationTF.text = @"1990-01-03";
        }
            break;
        case 3:
        {
            cell.headLabel.text = @"职业";
            cell.informationTF.text = @"其他";
        }
            break;
            
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
