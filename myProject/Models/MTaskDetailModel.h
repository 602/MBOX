//
//  MTaskDetailModel.h
//  myProject
//
//  Created by Charles_Wl on 15/10/6.
//  Copyright © 2015年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTaskDetailModel : NSObject
@property (nonatomic)NSInteger taskId;

@property (nonatomic, strong)NSString *sortNum;

@property (nonatomic)NSInteger taskImgHeight;

@property (nonatomic, strong)NSString *taskImgPath;

@property (nonatomic)NSInteger taskImgWidth;

@property (nonatomic)NSInteger taskItemAwardIntegral;

@property (nonatomic, strong)NSString *taskItemAwardMoney;

@property (nonatomic, strong)NSString *taskItemAwardType;

@property (nonatomic, strong)NSString *taskItemContent;

@property (nonatomic, strong)NSString *taskItemDeadline;

@property (nonatomic, strong)NSString *taskItemDesc;

@property (nonatomic, strong)NSString *taskItemName;

@property (nonatomic, strong)NSString *taskItemOrder;

@property (nonatomic, strong)NSString *taskItemUrl;

@property (nonatomic)NSInteger taskItemType;

@property (nonatomic)NSInteger taskRemainCopies;
@end
