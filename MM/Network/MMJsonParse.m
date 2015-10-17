//
//  MMJsonParse.m
//  myProject
//
//  Created by wangtao on 15/6/2.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "MMJsonParse.h"
#import "MTaskDetailModel.h"
@implementation MMJsonParse

+(MUserModel *)parseMUserModel:(NSDictionary *)dic {
    MUserModel *mUserModel = [MUserModel sharedMUserModel];
    mUserModel.appPushToken = [[dic objectForKey:@"appPushToken"]safeString];
    mUserModel.resultMsg = [[dic objectForKey:@"resultMsg"]safeString];
    mUserModel.tokenId = [[dic objectForKey:@"tokenId"]safeString];
    mUserModel.statusCode = [[dic objectForKey:@"statusCode"]integerValue];
    //用户数据
    NSDictionary *obj = [dic objectForKey:@"data"];
    mUserModel.userIndex = [[obj objectForKey:@"userIndex"] integerValue];
    mUserModel.userSmallHeadImgUrl = [[obj objectForKey:@"userSmallHeadImgUrl"]safeString];
    mUserModel.userNick = [[obj objectForKey:@"userNick"]safeString];
    mUserModel.userSex = [[obj objectForKey:@"userSex"]safeString];
    mUserModel.userBirthday = [[obj objectForKey:@"userBirthday"]safeString];
    mUserModel.userProfession = [[obj objectForKey:@"userProfession"]safeString];
    mUserModel.userCity = [[obj objectForKey:@"userCity"]safeString];
    
    return mUserModel;
}

+(MTaskListModel *)parseMTaskListModel:(NSDictionary *)dic {
    if ([dic isKindOfClass:[NSDictionary class]]) {
        NSDictionary *taskDic = [dic objectForKey:@"data"];
    
    MTaskListModel *mTaskListModel = [[MTaskListModel alloc]init];
    mTaskListModel.firstPage = [taskDic objectForKey:@"firstPage"];
    mTaskListModel.firstResult = [taskDic objectForKey:@"firstResult"];
    mTaskListModel.lastPage = [taskDic objectForKey:@"lastPage"];
    NSArray *taskArray = [[taskDic objectForKey:@"list"]safeArray];
    NSMutableArray *listarray = [NSMutableArray arrayWithCapacity:2];
    if ([taskArray isKindOfClass:[NSArray class]]&&taskArray.count) {
        QQLog(@"长度:%ld",taskArray.count);
        for (NSDictionary *dic in taskArray) {
            MTaskDetailModel *taskDetail = [[MTaskDetailModel alloc]init];
            taskDetail.taskId = [[dic objectForKey:@"id"]integerValue];
            taskDetail.sortNum = [dic objectForKey:@"sortNum"];
            taskDetail.taskImgHeight = [[dic objectForKey:@"taskImgHeight"]integerValue];
            taskDetail.taskImgWidth = [[dic objectForKey:@"taskImgWidth"]integerValue];
            taskDetail.taskImgPath = [[dic objectForKey:@"taskImgPath"]safeString];
            taskDetail.taskItemAwardIntegral = [[dic objectForKey:@"taskItemAwardIntegral"]integerValue];
            taskDetail.taskItemName = [[dic objectForKey:@"taskItemName"]safeString];
            [listarray addObject:taskDetail];
            QQLog(@"数组变化:%ld",listarray.count);
        }
        QQLog(@"数组里有多少:%ld",listarray.count);
        mTaskListModel.list = listarray;
     }
        return mTaskListModel;
    }else{
        return nil;
    }
}

@end
