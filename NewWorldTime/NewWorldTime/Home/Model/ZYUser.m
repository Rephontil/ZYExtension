//
//  ZYUser.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/11/28.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "ZYUser.h"

@implementation ZYUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}


@end
