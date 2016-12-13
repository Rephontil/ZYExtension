//
//  ZYPopMenu.h
//  NewWorldTime
//
//  Created by ZhouYong on 16/11/20.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYPopMenu : UIImageView


/**
 内容视图
 */
@property (nonatomic, weak) UIView *contentView;

/**
 显示弹窗菜单

 @param rect 弹窗的frame
 @return 弹窗
 */
+ (instancetype)showInRect:(CGRect)rect;


/**
 隐藏弹窗菜单
 */
+ (void)hide;


@end
