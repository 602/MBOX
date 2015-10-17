//
//  MenuListModel.m
//  myProject
//
//  Created by charles on 15/7/27.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "MenuListModel.h"

@implementation MenuListModel
- (id)initWithImg:(NSString *)img Title:(NSString *)title SubTitle:(NSString *)subTitle {
    self = [super init];
    self.img = img;
    self.title = title;
    self.subTitle = subTitle;
    return self;
}
+(NSArray *)listarr{
    //测试数据
    MenuListModel *model1 = [[MenuListModel alloc]initWithImg:@"me_icon06" Title:@"雷雷" SubTitle:@"已经赚钱10000元"];
    MenuListModel *model2 = [[MenuListModel alloc]initWithImg:@"me_icon06" Title:@"涛涛" SubTitle:@"已经赚钱8000元"];
    MenuListModel *model3 = [[MenuListModel alloc]initWithImg:@"me_icon06" Title:@"航航" SubTitle:@"已经赚钱6000元"];
    MenuListModel *model4 = [[MenuListModel alloc]initWithImg:@"me_icon06" Title:@"欢欢" SubTitle:@"已经赚钱5000元"];
    return  @[model1,model2,model3,model4];
}
@end
