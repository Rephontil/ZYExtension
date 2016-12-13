//
//  ZYNewFeatureCell.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/11/21.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//  新特性的cell

#import "ZYNewFeatureCell.h"

@interface ZYNewFeatureCell ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIButton *shareButton;
@property (nonatomic, weak) UIButton *startButton;

@end

@implementation ZYNewFeatureCell

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        _imageView = imageV;
        [self.contentView addSubview:imageV];

    }
    return _imageView;
}

- (UIButton *)shareButton
{
    if (_shareButton == nil) {
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        shareButton.highlighted = NO;
        [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateHighlighted];
        [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
        [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [shareButton sizeToFit];
        _shareButton = shareButton;
        [self.contentView addSubview:shareButton];

    }
    return _shareButton;
}

- (UIButton *)startButton
{
    if (_startButton == nil) {
        UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted-1"] forState:UIControlStateHighlighted];
        [startButton setTitle:@"开始新世界" forState:UIControlStateNormal];
        [startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [startButton addTarget:self action:@selector(startToNewWorld) forControlEvents:UIControlEventTouchUpInside];
        [startButton sizeToFit];
        _startButton = startButton;
        [self.contentView addSubview:startButton];


    }
    return _startButton;
}

- (void)startToNewWorld
{
    if ([self.delegate respondsToSelector:@selector(delegateTestComplete)]) {
        [self.delegate delegateTestComplete];

    }
}


/**
 留给外部提供图片的字段

 @param image image的set方法
 */
- (void)setImage:(UIImage *)image
{
    _image = image;

    self.imageView.image = image;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.startButton.center = CGPointMake(K_SCREEN_WIDTH/2.0, 0.85 * K_SCREEN_HEIGHT);


    self.shareButton.center = CGPointMake(K_SCREEN_WIDTH/2.0, 0.75 * K_SCREEN_HEIGHT);
    CGRect rectBounds = self.shareButton.bounds;
    CGRect rectFrame = self.shareButton.frame;
    ZYLog(@"rectBounds--->%@，rectFrame----->%@",NSStringFromCGRect(rectBounds),NSStringFromCGRect(rectFrame));


//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(131, 450, 113, 20)];
//    view.backgroundColor = [UIColor redColor];
//    [self.contentView addSubview:view];
//
//    UIView *childView = [[UIView alloc] init];
//    [view addSubview:childView];
//    childView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
//    childView.frame = view.bounds;
//
//    CGRect rect = self.shareButton.frame;
//    CGFloat min_X = CGRectGetMinX(rect);
//    CGFloat max_X = CGRectGetMaxX(rect);
//    ZYLog(@"%f %f",min_X,max_X);

}

// 在最后一页,显示分享和开始按钮

/**
 在最后一页显示分享和开始的按钮

 @param indexPath 传入当前page的坐标
 @param pageCount 一共有多少页要显示
 */

- (void)setViewAtIndexPath:(NSIndexPath *)indexPath pageCount:(NSInteger)pageCount
{
    if (indexPath.row == pageCount - 1) { //最后一页
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
    }else{
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }

}


@end
