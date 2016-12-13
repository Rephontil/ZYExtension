//
//  ZYAccount.m
//  NewWorldTime
//
//  Created by ZhouYong on 15/11/27.
//  Copyright © 2015年 ZhouYong. All rights reserved.
//  账户信息类

#import "ZYAccount.h"

#define Access_token   @"access_token"

#define Expires_in     @"expires_in"

#define Uid  @"uid"

//过期时间
#define Remind_Date  @"remind_Date"



@implementation ZYAccount

/**
 *  KVC底层实现：遍历字典里的所有key(uid)
 一个一个获取key，会去模型里查找setKey: setUid:,直接调用这个方法，赋值 setUid:obj
 寻找有没有带下划线_key,_uid ,直接拿到属性赋值
 寻找有没有key的属性，如果有，直接赋值
 在模型里面找不到对应的Key,就会报错.
 */


/**
 字典转模型（获取到的用户数据转化成用户的模型）

 @param dic 用户数据字典
 @return 用户模型
 */
+ (instancetype)accountWithDic:(NSDictionary *)dic
{
    ZYAccount *account = [[self alloc] init];
    [account setValuesForKeysWithDictionary:dic];
    return account;
}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
//    过期时间 = 现在的时间 + expires_in（生命周期）
    _remind_Date = [NSDate dateWithTimeIntervalSinceNow:[_expires_in longLongValue]];
}


#pragma mark  模型序列化和反序列化操作
/**
 归档的时候用，告诉系统哪个属性需要归档，怎么归档

 @param aCoder aCoder description
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:Access_token];
    [aCoder encodeObject:_expires_in   forKey:Expires_in];
    [aCoder encodeObject:_uid forKey:Uid];
    [aCoder encodeObject:_remind_Date forKey:Remind_Date];

}

/**
 解档的时候调用，哪些属性需要解档。

 @param aDecoder aDecoder description
 @return return value description
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
//        反序列化的时候一定记得将反序列话的结果赋值给模型中对应的属性
        _access_token = [aDecoder decodeObjectForKey:Access_token];
        _expires_in = [aDecoder decodeObjectForKey:Expires_in];
        _uid = [aDecoder decodeObjectForKey:Uid];
        _remind_Date = [aDecoder decodeObjectForKey:Remind_Date];
    }
    return self;

}



@end
