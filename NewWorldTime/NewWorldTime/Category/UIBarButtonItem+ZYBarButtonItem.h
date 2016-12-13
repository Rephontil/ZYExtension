//
//  UIBarButtonItem+ZYBarButtonItem.h
//  NewWorldTime
//
//  Created by ZhouYong on 15/5/20.
//  Copyright © 2015年 ZhouYong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZYBarButtonItem)

/**
 返回UIBarButtonItem对象

 @param image 正常情况下的图片
 @param highImage 高亮显示的图片
 @param target 触发时间相应的代理对象
 @param action 动作
 @param controlEvents 什么事件触发（UIControlEvents）
 @return UIBarButtonItem的实例
 */
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
