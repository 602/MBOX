//
//  NetWorkRequest.h
//  myProject
//
//  Created by Apple on 15/5/31.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface NetWorkRequest : NSObject
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;
@property (strong, nonatomic) NSString *basicURL;
+ (NetWorkRequest *)sharedNetWorkRequest;

/**
 *  ios自带的get请求方式
 *
 *  @return block
 */
-(void)getByApiName:(NSString *)apiName
             Params:(NSString *)params
            success:(DictionaryBlock)success
            failure:(ErrorBlock)failure;

/**
 *  ios自带的post请求方式
 *
 *  @return block
 */
-(void)postByApiName:(NSString *)apiName
              Params:(id)params
             success:(ObjectBlock)success
             failure:(ErrorBlock)failure;

/**
 *  第三方的get请求方式
 */
-(void)AFGetByApiName:(NSString *)apiName
               Params:(id)params
              success:(ObjectBlock)success
              failure:(ErrorBlock)failure;

/**
 *  第三方的post请求方式
 */
-(void)AFPostByApiName:(NSString *)apiName
                Params:(id)params
               success:(ObjectBlock)success
               failure:(ErrorBlock)failure;

/**
 *  第三方的post上传多张图片请求方式
 */
-(void)AFPostImageByApiName:(NSString *)apiName
                     Params:(id)params
                ImagesArray:(NSArray*)images
                    success:(ObjectBlock)success
                    failure:(ErrorBlock)failure;

/**
 *  第三方的post上传单张图片请求方式
 */
-(void)AFPostImageByApiName:(NSString *)apiName
                  ImageName:(NSString*)imageName
                     Params:(id)params
                      Image:(UIImage*)image
                    success:(ObjectBlock)success
                    failure:(ErrorBlock)failure;


@end
