//
//  ZYAccountTool.h
//  NewWorldTime
//
//  Created by ZhouYong on 15/11/27.
//  Copyright © 2015年 ZhouYong. All rights reserved.
//  账号工具类，用于保存和读取账户信息

#import <Foundation/Foundation.h>
@class ZYAccount;

@interface ZYAccountTool : NSObject


/**
 存放账号

 @param account account description
 */
+ (void)saveAccount:(ZYAccount *)account;


/**
 读取账号

 @return 账户信息
 */
+ (ZYAccount *)account;

@end
