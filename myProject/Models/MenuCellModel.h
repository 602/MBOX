//
//  MenuCellModel.h
//  myProject
//
//  Created by Apple on 15/5/31.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuCellModel : NSObject
@property (strong, nonatomic) NSString *img;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subTitle;
+(NSArray *)listCellarr;
- initWithImg:(NSString *)img Title:(NSString *)title SubTitle:(NSString *)subTitle;
@end
