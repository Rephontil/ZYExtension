//
//  ZYPopMenu.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/11/20.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "ZYPopMenu.h"
#import "UIImage+ZYImage.h"

@implementation ZYPopMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


/**
 显示弹窗菜单

 @param rect 弹窗的frame
 @return 弹窗
 */
+ (instancetype)showInRect:(CGRect)rect
{
    ZYPopMenu *popMenu = [[ZYPopMenu alloc] initWithFrame:rect];
    popMenu.userInteractionEnabled = YES;
    popMenu.image = [UIImage imageWithStretchableName:@"popover_background"];
    [ZYKeyWindow addSubview:popMenu];
    return popMenu;

}


/**
 隐藏弹窗菜单
 */
+ (void)hide
{
    for (UIView *popView in ZYKeyWindow.subviews) {
        if ([popView isKindOfClass:[self class]]) {
            [popView removeFromSuperview];
        }
    }
}

// 设置内容视图
- (void)setContentView:(UIView *)contentView
{
    // 先移除之前内容视图
    [_contentView removeFromSuperview];

    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];

    [self addSubview:contentView];

}

- (void)layoutSubviews
{
    [super layoutSubviews];

    // 计算内容视图尺寸
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;

    _contentView.frame = CGRectMake(x, y, w, h);

}


@end
