//
//  MTaskListModel.h
//  myProject
//
//  Created by Charles_Wl on 15/10/6.
//  Copyright © 2015年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTaskListModel : NSObject
@property (nonatomic ,strong)NSString *firstPage;
@property (nonatomic ,strong)NSString *firstResult;
@property (nonatomic ,strong)NSString *lastPage;
@property (nonatomic ,strong)NSMutableArray *list;
@end
