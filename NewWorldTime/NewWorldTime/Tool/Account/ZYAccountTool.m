//
//  ZYAccountTool.m
//  NewWorldTime
//
//  Created by ZhouYong on 15/11/27.
//  Copyright © 2015年 ZhouYong. All rights reserved.
//  账号工具类，用于保存和读取账户信息

#import "ZYAccountTool.h"
#import "ZYAccount.h"

#define ZYAccountFilePath   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation ZYAccountTool

// 类方法一般用静态变量代替成员属性

static  ZYAccount *_account;

+ (void)saveAccount:(ZYAccount *)account
{
//        保存模型对象,归档的模型需要遵循NSCoding协议
    ZYLog(@"ZYAccountFilePath = %@",ZYAccountFilePath);
    [NSKeyedArchiver archiveRootObject:account toFile:ZYAccountFilePath];
    
}

+ (ZYAccount *)account
{
//    如果账户为空，就存储账户信息
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:ZYAccountFilePath];
//        如果账户过期了，就返回nil
        if ([[NSDate date] compare:_account.remind_Date] != NSOrderedAscending) {
            return nil;

        }

    }
    return _account;
}


@end
