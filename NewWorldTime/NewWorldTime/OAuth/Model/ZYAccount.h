//
//  ZYAccount.h
//  NewWorldTime
//
//  Created by ZhouYong on 15/11/27.
//  Copyright © 2015年 ZhouYong. All rights reserved.
//  账户信息类

#import <Foundation/Foundation.h>

@interface ZYAccount : NSObject<NSCoding>

/**
 访问的令牌
 */
@property(nonatomic, copy)NSString* access_token;
/**
expires_in的生命周期，单位是秒数。
 */
@property(nonatomic, copy)NSString* expires_in;
/**
 remind_in的生命周期（该参数即将废弃，开发者请使用expires_in）。
 */
@property(nonatomic, copy)NSString* remind_in;
/**
 授权用户的UID
 */
@property(nonatomic, copy)NSString* uid;
/**
 过期时间
 */
@property(nonatomic, strong)NSDate* remind_Date;



/**
 字典转模型（获取到的用户数据转化成用户的模型）

 @param dic 用户数据字典
 @return 用户模型
 */
+ (instancetype)accountWithDic:(NSDictionary *)dic;

@end
