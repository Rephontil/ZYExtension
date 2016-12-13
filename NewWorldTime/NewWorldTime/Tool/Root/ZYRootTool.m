//
//  ZYRootTool.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/11/27.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "ZYRootTool.h"
#import "ZYTabBarController.h"
#import "ZYNewFeatureController.h"

static NSString *ZYVersionKey = @"CFBundleVersion";

@implementation ZYRootTool


/**
 选择根视图控制器

 @param window 要传入的主窗口
 */
+ (void)chooseRootViewController:(UIWindow *)window
{
    NSString *currentVersionString = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];

    NSString *formalVersionString = [[NSUserDefaults standardUserDefaults] objectForKey:ZYVersionKey];

    if ([currentVersionString isEqualToString:formalVersionString]) {

        ZYTabBarController *tabBar = [[ZYTabBarController alloc] init];
        window.rootViewController = tabBar;
    }else{
        ZYNewFeatureController *newFeatureVC = [[ZYNewFeatureController alloc] init];
        window.rootViewController = newFeatureVC;
        [[NSUserDefaults standardUserDefaults] setObject:currentVersionString forKey:ZYVersionKey];
    }
    
}

@end
