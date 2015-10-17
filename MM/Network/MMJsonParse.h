//
//  MMJsonParse.h
//  myProject
//
//  Created by wangtao on 15/6/2.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUserModel.h"
#import "MTaskListModel.h"
/**
 *  解析类，其他的自己补充
 */
@interface MMJsonParse : NSObject
/**
 *  解析用户
 */
+ (MUserModel *)parseMUserModel:(NSDictionary *)dic;
/**
 *  解析限时推荐列表
 */
+ (MTaskListModel *)parseMTaskListModel:(NSDictionary *)dic;

@end
