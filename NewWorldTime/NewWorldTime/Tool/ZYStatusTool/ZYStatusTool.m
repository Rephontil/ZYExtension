//
//  ZYStatusTool.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/12/13.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "ZYStatusTool.h"
#import "ZYStatusPara.h"
#import "ZYAccountTool.h"
#import "ZYAccount.h"
#import "ZYHttpTool.h"
#import <MJExtension.h>
#import "ZYStatus.h"

@implementation ZYStatusTool

/**
 *  请求更新的微博数据
 sinceId：返回比这个更大的微博数据
 success：请求成功的时候回调(statuses(ZYStatus模型))
 failure:请求失败的时候回调，错误传递给外界

 */
+ (void)newStatusWithSinceId:(NSString *)sinceId
                     success:(void(^)(NSArray *modelArray))success
                     failure:(void(^)(NSError *error))failure
{
    ZYStatusPara *para = [ZYStatusPara sharedManager];
    para.access_token = [ZYAccountTool account].access_token;

    if (sinceId) {
        para.since_id = sinceId;
    }

    [ZYHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:para.mj_keyValues progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        ZYLog(@"%@",responseObject);
        NSArray *dicArray = responseObject[@"statuses"];

        NSArray *modelArray = [ZYStatus mj_objectArrayWithKeyValuesArray:dicArray];

        if (success) {
            success(modelArray);
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {


        if (failure) {
            failure(error);
        }
    }];

}

+ (void)moreStatusWithMaxId:(NSString *)maxid
                    success:(void(^)(NSArray *modelArray))success
                    failure:(void(^)(NSError *error))failure
{
    ZYStatusPara *para = [ZYStatusPara sharedManager];
    para.access_token = [ZYAccountTool account].access_token;
    if (maxid) {
        para.max_id = maxid;
    }
//    网络数据请求
    [ZYHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:para.mj_keyValues progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dicArray = responseObject[@"statuses"];
        NSArray *modelArray = [ZYStatus mj_objectArrayWithKeyValuesArray:dicArray];
        if (success) {
            success(modelArray);
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }

    }];

}


@end
