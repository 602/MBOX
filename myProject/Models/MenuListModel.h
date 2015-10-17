//
//  MenuListModel.h
//  myProject
//
//  Created by charles on 15/7/27.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuListModel : NSObject
@property (strong, nonatomic) NSString *img;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subTitle;
- initWithImg:(NSString *)img Title:(NSString *)title SubTitle:(NSString *)subTitle;
+(NSArray*)listarr;
@end
