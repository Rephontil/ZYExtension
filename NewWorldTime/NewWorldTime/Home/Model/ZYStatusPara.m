//
//  ZYStatusPara.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/12/13.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "ZYStatusPara.h"

@implementation ZYStatusPara

+ (instancetype)sharedManager
{
    static ZYStatusPara *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[ZYStatusPara alloc] init];
    });
    return _instance;

}



@end
