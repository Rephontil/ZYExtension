//
//  ZYHttpTool.h
//  NewWorldTime
//
//  Created by ZhouYong on 16/12/4.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHttpTool : NSObject



/**
 GET请求方式

 @param URLString 请求的主URL
 @param parameters 请求参数
 @param progress 进度
 @param success 成功的回调
 @param failure 失败的回调
 */
+ (void)get:(NSString *)URLString
 parameters:(id)parameters
   progress:(void(^)(NSProgress *downloadProgress))progress
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
