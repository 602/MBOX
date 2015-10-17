//
//  MenuCellModel.m
//  myProject
//
//  Created by Apple on 15/5/31.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "MenuCellModel.h"

@implementation MenuCellModel
- (id)initWithImg:(NSString *)img Title:(NSString *)title SubTitle:(NSString *)subTitle {
    self = [super init];
    self.img = img;
    self.title = title;
    self.subTitle = subTitle;
    return self;
}
+(NSArray *)listCellarr{
    //测试数据
    MenuCellModel *model1 = [[MenuCellModel alloc]initWithImg:@"time" Title:@"限时推荐" SubTitle:@"100%实时返钱"];
    MenuCellModel *model2 = [[MenuCellModel alloc]initWithImg:@"money" Title:@"有偿转发" SubTitle:@"邀请一个赚一个"];
    MenuCellModel *model3 = [[MenuCellModel alloc]initWithImg:@"teach" Title:@"新手教程" SubTitle:@"完成就是钱"];
    MenuCellModel *model4 = [[MenuCellModel alloc]initWithImg:@"award" Title:@"每日抽奖" SubTitle:@"每天抽取大奖"];
    return  @[model1,model2,model3,model4];
}
@end
