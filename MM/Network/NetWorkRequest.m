//
//  NetWorkRequest.m
//  myProject
//
//  Created by Apple on 15/5/31.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "NetWorkRequest.h"

static  NetWorkRequest *  netWorkRequest = nil;

@implementation NetWorkRequest

SINGLETON_GCD(NetWorkRequest);

#pragma mark - Http 请求网络数据方法
/**
 *  ios自带的get请求方式
 *
 *  @return block
 */
- (void)getByApiName:(NSString *)apiName
             Params:(NSString *)params
            success:(DictionaryBlock)success
            failure:(ErrorBlock)failure{
    
    NSString *path = nil;
    if (params.length) {
        path = [NSString stringWithFormat:@"%@%@?%@",self.basicURL,apiName,params];
    }else{
        path = [NSString stringWithFormat:@"%@%@",self.basicURL,apiName];
    }
    
    NSString*  pathStr = [path  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:pathStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            id  jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
            if ([jsonData  isKindOfClass:[NSArray  class]]) {
                NSDictionary*  dic = jsonData[0];
                success(dic);
            }else{
                success(jsonData);
            }
        }else {
            failure(error);
        }
        
    }];
    //开始请求
    [task resume];
}

/**
 *  ios自带的post请求方式
 *
 *  @return block
 */
- (void)postByApiName:(NSString *)apiName
              Params:(NSDictionary*)params
             success:(DictionaryBlock)success
             failure:(ErrorBlock)failure{
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",self.basicURL,apiName];
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSError*  error;
    
    if ([NSJSONSerialization isValidJSONObject:params]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        [request  setHTTPBody:jsonData];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (!error) {
                NSString*  str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                QQLog(@"..........%@",str);
                id  jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
                if ([jsonData  isKindOfClass:[NSArray  class]]) {
                    NSDictionary*  dic = jsonData[0];
                    success(dic);
                }else{
                    success(jsonData);
                }
            }else {
                failure(error);
            }
        }];
        //开始请求
        [task resume];
        
    }
}


#pragma mark 第三方请求方式
/**
 *  第三方的get请求方式 异步
 *
 *  @param apiName 接口名称
 *  @param params  参数
 *  @param success 成功block回调
 *  @param failure 失败block回调
 */
- (void)AFGetByApiName:(NSString *)apiName
               Params:(id)params
              success:(ObjectBlock)success
              failure:(ErrorBlock)failure{
    
    [self.manager GET:[NSString stringWithFormat:@"%@%@",self.basicURL,apiName] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //QQLog(@"JSON: %@", responseObject);
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //QQLog(@"Error: %@", error);
        failure(error);
    }];
    
}
/**
 *  第三方的post请求方式 异步
 *
 *  @param apiName 接口名称
 *  @param params  参数
 *  @param success 成功block回调
 *  @param failure 失败block回调
 */
-(void)AFPostByApiName:(NSString *)apiName
                Params:(NSDictionary *)params
               success:(ObjectBlock)success
               failure:(ErrorBlock)failure{

    [self.manager POST:[NSString stringWithFormat:@"%@%@",self.basicURL,apiName] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //QQLog(@"JSON: %@", responseObject);
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //QQLog(@"Error: %@", error);
        failure(error);
    }];
    
}
/**
 *  第三方的post上传多张图片请求方式
 *
 *  @param apiName 上传api
 *  @param params  参数
 *  @param images  图片数组
 *  @param success -
 *  @param failure -
 */
-(void)AFPostImageByApiName:(NSString *)apiName
                     Params:(id)params
                ImagesArray:(NSArray*)images
                    success:(ObjectBlock)success
                    failure:(ErrorBlock)failure{
    
    [self.manager POST:apiName parameters:params constructingBodyWithBlock:^(id formData) {
        
        for (int i = 0; i<images.count; i++) {
            NSData*  imageData = UIImageJPEGRepresentation([self fixOrientation:images[i]], 0.8);
            NSString*  name =nil;
            if (images.count == 1) {
                name = @"imageFile";
            }else{
                name = [NSString   stringWithFormat:@"file%d",i+1];
            }
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"image.jpg"] mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
/**
 *  第三方的post上传单张图片请求方式
 *
 *  @param apiName 上传api
 *  @param params  参数
 *  @param image  图片
 *  @param success -
 *  @param failure -
 */
-(void)AFPostImageByApiName:(NSString *)apiName
                  ImageName:(NSString*)imageName
                     Params:(id)params
                      Image:(UIImage*)image
                    success:(ObjectBlock)success
                    failure:(ErrorBlock)failure{
    
    NSData*  imageData = UIImageJPEGRepresentation([self fixOrientation:image], 0.8);
    [self.manager POST:apiName parameters:params constructingBodyWithBlock:^(id formData) {
        [formData appendPartWithFileData:imageData name:imageName fileName:[NSString stringWithFormat:@"image.jpg"] mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

//对照片进行处理之前，先将照片旋转到正确的方向，并且返回的imageOrientaion为0。
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
#pragma mark - Getters
- (AFHTTPRequestOperationManager *)manager {

    if (!_manager) {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return _manager;
}

@end
