//
//  ZYStatusTool.h
//  NewWorldTime
//
//  Created by ZhouYong on 16/12/13.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYStatusTool : NSObject

/**
 *  请求更新的微博数据
 sinceId：返回比这个更大的微博数据
 success：请求成功的时候回调(statuses(ZYStatus模型))
 failure:请求失败的时候回调，错误传递给外界

 */
+ (void)newStatusWithSinceId:(NSString *)sinceId
                     success:(void(^)(NSArray *modelArray))success
                     failure:(void(^)(NSError *error))failure;


@end
