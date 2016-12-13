//
//  ZYHttpTool.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/12/4.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "ZYHttpTool.h"
#import <AFNetworking.h>


@implementation ZYHttpTool


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
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // 获取http请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];

    [mgr GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }

    }];

}



@end










