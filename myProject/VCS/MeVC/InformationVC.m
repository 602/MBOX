//
//  InformationVC.m
//  myProject
//
//  Created by Charles_Wl on 15/8/17.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "InformationVC.h"
#import "infoCell.h"

@interface InformationModel : NSObject
@property (strong ,nonatomic) NSString *userNick;
@property (strong ,nonatomic) NSString *userSex;
@property (strong ,nonatomic) NSString *userBirthday;
@property (strong ,nonatomic) NSString *userProfession;
@property (strong ,nonatomic) NSString *userCity;
+ (InformationModel *)infoModel;
@end

@implementation InformationModel

+ (InformationModel *)infoModel {
    InformationModel *model = [[InformationModel alloc] init];
    if ([MUserModel sharedMUserModel].userNick) {
        model.userNick = [MUserModel sharedMUserModel].userNick;
    }else {
        model.userNick = @"修改昵称";
    }
    if ([MUserModel sharedMUserModel].userNick) {
        model.userSex = [MUserModel sharedMUserModel].userSex;
    }else {
        model.userSex = @"修改性别";
    }
    if ([MUserModel sharedMUserModel].userNick) {
        model.userBirthday = [MUserModel sharedMUserModel].userBirthday;
    }else {
        model.userBirthday = @"修改生日";
    }
    if ([MUserModel sharedMUserModel].userNick) {
        model.userProfession = [MUserModel sharedMUserModel].userProfession;
    }else {
        model.userProfession = @"修改职业 ";
    }
    if ([MUserModel sharedMUserModel].userNick) {
        model.userCity = [MUserModel sharedMUserModel].userCity;
    }else {
        model.userCity = @"修改城市";
    }
    return model;
}

@end

@interface InformationVC ()<UITableViewDataSource,UITableViewDelegate,infoCellDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UITableView *infoTV;
@property (strong, nonatomic) IBOutlet UIView *infoHV;
@property (strong, nonatomic) IBOutlet UIButton *commitButton;

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) InformationModel *infoModel;
@property (strong, nonatomic) UIImage *headImage;
@end

@implementation InformationVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    [self initData];
    [self initTableView];
    
}

#pragma mark - Private Method

- (void)initData {
    self.infoModel = [InformationModel infoModel];
    self.dataArray = @[self.infoModel.userNick,self.infoModel.userSex,self.infoModel.userBirthday,self.infoModel.userProfession,self.infoModel.userCity];
}

- (void)initTableView {
    self.infoTV.tableHeaderView = self.infoHV;
    self.infoTV.tableFooterView = self.commitButton;
    self.infoTV.delegate = self;
    self.infoTV.dataSource = self;
    UINib* nib = [UINib nibWithNibName:@"infoCell" bundle:nil];
    [self.infoTV registerNib:nib forCellReuseIdentifier:infoCellIdentifier];
    self.infoTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickOnHeadImage:)];
    [self.headImageView addGestureRecognizer:tap];
}

#pragma mark - UITableViewDatasourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *detailText = self.dataArray[indexPath.row];
    infoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    switch (indexPath.row) {
        case 0: {
            cell.headLabel.text = @"昵称";
        }
            break;
        case 1: {
            cell.headLabel.text = @"性别";
        }
            break;
        case 2: {
            cell.headLabel.text = @"生日";
        }
            break;
        case 3: {
            cell.headLabel.text = @"职业";
        }
            break;
        case 4: {
            cell.headLabel.text = @"城市";
        }
            break;
            
        default:
            break;
    }
    cell.informationTF.text = detailText;
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

#pragma mark - Event Respnoce

- (IBAction)commitAction:(UIButton *)sender {
     NSDictionary *param = [NSDictionary dictionaryWithObjects:@[[Cache sharedCache].tokenId,self.headImage ,self.infoModel.userNick,self.infoModel.userSex,self.infoModel.userBirthday,self.infoModel.userProfession,self.infoModel.userCity] forKeys:@[@"tokenId",@"imageFile",@"userNick",@"userSex",@"userBirthday",@"userProfession",@"userCity"]];
    [Utils showLoadingView];
    [[NetWorkApi sharedNetWorkApi] updateUserInfo:param success:^(id obj) {
        [Utils hideLoadingView];
        [self initData];
        [self.infoTV reloadData];
    } failure:^(NSError *error) {
        [Utils showToastWithText:@"网络错误！"];
    }];
}

- (void)didClickOnHeadImage:(UITapGestureRecognizer *)tap {
    
}

- (void)textFieldDidChange:(infoCell *)cell {
    NSLog(@"更新资料");
    if ([cell.headLabel.text isEqualToString:@"昵称"]) {
        self.infoModel.userNick = cell.informationTF.text;
    }else if ([cell.headLabel.text isEqualToString:@"性别"]) {
        self.infoModel.userSex = cell.informationTF.text;
    }
    else if ([cell.headLabel.text isEqualToString:@"生日"]) {
        self.infoModel.userBirthday = cell.informationTF.text;
    }
    else if ([cell.headLabel.text isEqualToString:@"职业"]) {
        self.infoModel.userProfession = cell.informationTF.text;
    }
    else if ([cell.headLabel.text isEqualToString:@"城市"]) {
        self.infoModel.userCity = cell.informationTF.text;
    }
}

#pragma mark - Setters and Getters


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
