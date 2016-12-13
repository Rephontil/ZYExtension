//
//  ZYStatus.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/11/28.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "ZYStatus.h"
#import "ZYPhoto.h"

@implementation ZYStatus

// 实现这个方法，就会自动把数组中的字典转换成对应的模型
+ (NSDictionary *)mj_objectClassInArray;
{
    return @{@"pic_urls":[ZYPhoto class]};
}


@end
