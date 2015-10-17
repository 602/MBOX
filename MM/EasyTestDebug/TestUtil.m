//
//  TestUtil.m
//  QQing
//
//  Created by Ben on 6/10/14.
//  Copyright (c) 2014 QQing. All rights reserved.
//

#import "TestUtil.h"

NSMutableString *g_testDebugString;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"
// 串行队列解决NSMutableString不是线程安全问题
static dispatch_queue_t writeLogOperationQueue() {
    static dispatch_queue_t s_writeLogOperationQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_writeLogOperationQueue = dispatch_queue_create("com.qq.teacher.writeLogQueue", DISPATCH_QUEUE_SERIAL);
        dispatch_queue_t priority = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_set_target_queue(priority, s_writeLogOperationQueue);
    });
    
    return s_writeLogOperationQueue;
}
#pragma clang diagnostic pop

@implementation TestUtil

+ (void)initialize
{
    NSArray *pathes = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [pathes[0] stringByAppendingPathComponent:@"QQingTestDebugLog.txt"];
    
    NSData *contentData =[NSData dataWithContentsOfFile:filePath];
    g_testDebugString = [[NSMutableString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
}

+ (NSData *)getLocalDataFromFileForDeveloper:(DEVELOPER_NAME)devName
{
    NSString *filePath = [TestUtil jsonFilePathForDeveloper:devName];
    return [NSData dataWithContentsOfFile:filePath];
}

+ (NSString *)getLocalDataStringFromFileForDeveloper:(DEVELOPER_NAME)devName
{
    NSString *filePath = [TestUtil jsonFilePathForDeveloper:devName];
    return [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
}

+ (id)getLocalDataObjectFromFileForDeveloper:(DEVELOPER_NAME)devName
{
    NSString *filePath = [TestUtil jsonFilePathForDeveloper:devName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    id content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    return content;
}

+ (void)appendTestDebugLog:(NSString *)fmt, ...
{
#if __DEBUG_VERSION
    @try {
        va_list args;
        va_start(args, fmt);
        NSString *debugText = [[NSString alloc] initWithFormat:fmt arguments:args];
        va_end(args);
        
        dispatch_async(writeLogOperationQueue(), ^{
            if (g_testDebugString) {
                [g_testDebugString appendString:[NSString stringWithFormat:@"%@\n\n", debugText]];
            }
        });
    }
    @catch (id e) {
        // Ignored
    }
#endif
}

+ (NSString *)currentTestDebugLog
{
    return g_testDebugString;
}

#pragma mark - Private Methods

+ (NSString *)jsonFilePathForDeveloper:(DEVELOPER_NAME)devName
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath;
    switch (devName) {
        case LIJIE: {
            filePath = [mainBundle pathForResource:@"LocalMockData_LiJie" ofType:@"txt"];
        }
            break;
            
        case ANBO: {
            filePath = [mainBundle pathForResource:@"LocalMockData_AnBo" ofType:@"txt"];
        }
            break;
            
        case TAOCHENG: {
            filePath = [mainBundle pathForResource:@"LocalMockData_TaoCheng" ofType:@"txt"];
        }
            break;
            
        case WANGTAO: {
            filePath = [mainBundle pathForResource:@"LocalMockData_WangTao" ofType:@"txt"];
        }
            break;
        
        case XIEXIAOFENG: {
            filePath = [mainBundle pathForResource:@"LocalMockData_XieXiaoFeng" ofType:@"txt"];
        }
            break;
            
        case GUOXIAOQIAN: {
            filePath = [mainBundle pathForResource:@"LocalMockData_GuoXiaoQian" ofType:@"txt"];
        }
            break;

        case XIAXUQIANG:
        default: {
            filePath = [mainBundle pathForResource:@"LocalMockData_XiaXuQiang" ofType:@"txt"];
            break;
        }
    }
    
    return filePath;
}

@end
