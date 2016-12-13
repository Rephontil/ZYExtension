//
//  ZYCover.m
//  NewWorldTime
//
//  Created by ZhouYong on 15-3-5.
//  Copyright (c) 2015年 ZhouYong. All rights reserved.
//

#import "ZYCover.h"

@implementation ZYCover

// 设置浅灰色蒙板
- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
    }else{
        self.alpha = 1;
        self.backgroundColor = [UIColor clearColor];
    }
}
// 显示蒙板
+ (instancetype)show
{
    ZYCover *cover = [[ZYCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    
    [ZYKeyWindow addSubview:cover];
    
    return cover;
  
}
// 点击蒙板的时候做事情
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 移除蒙板
    [self removeFromSuperview];
    
    // 通知代理移除菜单
    if ([_delegate respondsToSelector:@selector(coverDidClickCover:)]) {
        
        [_delegate coverDidClickCover:self];
        
    }
    
}

@end
