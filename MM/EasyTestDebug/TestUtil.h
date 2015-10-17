//
//  TestUtil.h
//  QQing
//
//  Created by Ben on 6/10/14.
//  Copyright (c) 2014 QQing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestViewControllerHome.h"

/*
 
 该工具类主要提供帮助测试的公用方法
 
 */

#define TestDebugLog(...) [TestUtil appendTestDebugLog:__VA_ARGS__]

typedef NS_ENUM(NSInteger, DEVELOPER_NAME) {
    LIJIE,
    ANBO,
    TAOCHENG,
    WANGTAO,
    XIEXIAOFENG,
    GUOXIAOQIAN,
    XIAXUQIANG,
};

@interface TestUtil : NSObject

//获得工程中相应的LocalMockData_***.txt文件中data
+ (NSData *)getLocalDataFromFileForDeveloper:(DEVELOPER_NAME)devName;

//获得工程中相应的LocalMockData_***.txt文件中字符串数据
+ (NSString *)getLocalDataStringFromFileForDeveloper:(DEVELOPER_NAME)devName;

//获得工程中相应的LocalMockData_***.txt文件中json串对应的对象(NSArray或NSDictionary,格式错误则为nil)
+ (id)getLocalDataObjectFromFileForDeveloper:(DEVELOPER_NAME)devName;

/**
 *  打印临时日志，方便测试页面输出，只有__DEBUG_VERSION为非0才记录
 *
 *  使用样例:
 *  1.[TestUtil appendTestDebugLog:@"hello world"];
 *  2.[TestUtil appendTestDebugLog:@"hello %@", @"world"];
 *  3.TestDebugLog(@"hello, world");
 *  4.TestDebugLog(@"hello %@", @"world");
 */
+ (void)appendTestDebugLog:(NSString *)fmt, ...;

+ (NSString *)currentTestDebugLog;

@end
