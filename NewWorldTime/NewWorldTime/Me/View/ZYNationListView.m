//
//  ZYNationListView.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/12/26.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "ZYNationListView.h"


@implementation ZYNationListView


- (UIButton *)rightImage
{
    if (_rightImage == nil) {
        _rightImage = [[UIButton alloc] init];
    }
    return _rightImage;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];

        [self layoutChildViews];

    }
    return self;
}

- (void)layoutChildViews
{
    //左边视图的宽度
    CGFloat leftViewWidth = self.width - 20;
    CGFloat leftViewHeight = self.height;
    CGFloat rightViewHeight = self.height;

    _leftButtonView = [JXLayoutButton buttonWithType:UIButtonTypeCustom];
    _leftButtonView.layoutStyle = JXLayoutButtonStyleLeftImageRightTitle;
    _leftButtonView.frame = CGRectMake(0, 0, leftViewWidth, leftViewHeight);
    _leftButtonView.selected = NO;
    _leftButtonView.highlighted = NO;
    [self addSubview:_leftButtonView];

//    _rightImage = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_leftButtonView.frame), 0, self.width - _leftButtonView.width, rightViewHeight/2.0)];
    _rightImage = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width, rightViewHeight)];
    CGPoint center;
    center.x = _rightImage.center.x;
    center.y = self.height/2.0;
    _rightImage.center = center;
    _rightImage.contentMode = UIViewContentModeScaleAspectFit;
    _rightImage.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -self.width + 30);
    [self addSubview:_rightImage];

}


@end
