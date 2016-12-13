//
//  MBProgressHUD+ZY.h
//
//  Created by ZhouYong on 15-4-18.
//  Copyright (c) 2015年 ZhouYong. All rights reserved.
//  对MBProgressHUD进行二次封装，方便使用

#import "MBProgressHUD.h"

@interface MBProgressHUD (ZY)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
