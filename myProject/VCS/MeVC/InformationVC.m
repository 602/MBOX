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
@property (strong ,nonatomic) NSString *title;
@property (strong ,nonatomic) NSString *subTitle;
+ (InformationModel *)modelWith:(NSString *)title and:(NSString *)subTitle;
@end

@implementation InformationModel

+ (InformationModel *)modelWith:(NSString *)title and:(NSString *)subTitle {
    InformationModel *model = [[InformationModel alloc] init];
    model.title = title;
    model.subTitle = subTitle;
    return model;
}

@end

@interface InformationVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UITableView *infoTV;
@property (strong, nonatomic) IBOutlet UIView *infoHV;
@property (strong, nonatomic) IBOutlet UIButton *commitButton;

@property (strong, nonatomic) NSArray *dataArray;

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
    
    InformationModel *model_1 = [InformationModel modelWith:@"昵称" and:[MUserModel sharedMUserModel].userNick];
    InformationModel *model_2 = [InformationModel modelWith:@"性别" and:[MUserModel sharedMUserModel].userSex];
    InformationModel *model_3 = [InformationModel modelWith:@"生日" and:[MUserModel sharedMUserModel].userBirthday];
    InformationModel *model_4 = [InformationModel modelWith:@"职业" and:[MUserModel sharedMUserModel].userProfession];
    InformationModel *model_5 = [InformationModel modelWith:@"城市" and:[MUserModel sharedMUserModel].userCity];
    self.dataArray = @[model_1,model_2,model_3,model_4,model_5];
    
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
    InformationModel *model = self.dataArray[indexPath.row];
    infoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellIdentifier forIndexPath:indexPath];
    cell.headLabel.text = model.title;
    cell.informationTF.text = model.subTitle;
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
    
    
}

- (void)didClickOnHeadImage:(UITapGestureRecognizer *)tap {
    
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
