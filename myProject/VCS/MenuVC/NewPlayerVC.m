//
//  NewPlayerVC.m
//  myProject
//
//  Created by 顾欢欢 on 15/8/16.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "NewPlayerVC.h"
#import "NewPlayerCell.h"
#import "ClassVC.h"
#import "QaVC.h"
#import "TaskVC.h"
@interface NewPlayerVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *playerTableView;
@end

@implementation NewPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新手教程";
    self.playerTableView.dataSource = self;
    self.playerTableView.delegate = self;
    UINib* nib = [UINib nibWithNibName:@"NewPlayerCell" bundle:nil];
    [self.playerTableView registerNib:nib forCellReuseIdentifier:newCellIdentifier];
}

#pragma mark - UITableViewDatasourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:newCellIdentifier forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
        {
            cell.contentLabel.text = @"新手教程";
            cell.headIV.image = [UIImage imageNamed:@"newplayer"];
        }
            break;
        case 1:
        {
            cell.contentLabel.text = @"新手任务";
            cell.headIV.image = [UIImage imageNamed:@"newplayer"];
        }
            break;
            
        case 2:
        {
            cell.contentLabel.text = @"新手问答";
            cell.headIV.image = [UIImage imageNamed:@"newplayer"];
        }
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return /*[MenuCell cellHeight]*/60;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            ClassVC *classVc = [[ClassVC alloc]_initWithNib];
            classVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:classVc animated:YES];
        }
            break;
        case 1:
        {
            TaskVC *taskVc = [[TaskVC alloc]_initWithNib];
            taskVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:taskVc animated:YES];
        }
            break;
        case 2:
        {
            QaVC *qaVc = [[QaVC alloc]_initWithNib];
            qaVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:qaVc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
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
