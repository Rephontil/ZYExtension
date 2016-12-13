//
//  ZYSearchBar.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/11/19.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "ZYSearchBar.h"
#import "UIImage+ZYImage.h"

@implementation ZYSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.font = [UIFont systemFontOfSize:13];

        self.background = [UIImage imageWithStretchableName:@"searchbar_textfield_background"];

        // 设置左边的view
        // initWithImage:默认UIImageView的尺寸跟图片一样
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imageV.width += 10;
        imageV.contentMode = UIViewContentModeCenter;
        self.leftView = imageV;
        // 一定要设置，想要显示搜索框左边的视图，一定要设置左边视图的模式
        self.leftViewMode = UITextFieldViewModeAlways;

    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end