//
//  UIView+ZYFrame.h
//  dajiaochong
//
//  Created by ZhouYong on 15-3-5.
//  Copyright (c) 2015年 ZhouYong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYFrame)
// 分类不能添加成员属性
// @property如果在分类里面，只会自动生成get,set方法的声明，不会生成成员属性，和方法的实现
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;


@end
