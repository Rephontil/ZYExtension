//
//  ZYOriginalView.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/12/25.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//  原创的部分view

#import "ZYOriginalView.h"
#import "ZYStatusFrame.h"
#import "ZYStatus.h"
#import "UIImageView+WebCache.h"


@interface ZYOriginalView ()

// 头像
@property (nonatomic, weak) UIImageView *iconView;


// 昵称
@property (nonatomic, weak) UILabel *nameView;


// vip
@property (nonatomic, weak) UIImageView *vipView;


// 时间
@property (nonatomic, weak) UILabel *timeView;

// 来源
@property (nonatomic, weak) UILabel *sourceView;


// 正文
@property (nonatomic, weak) UILabel *textView;

@end

@implementation ZYOriginalView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        //添加所有的子控件
        [self setUpAllChildrenView];
    }
    return self;
}

//添加所有的子控件
- (void)setUpAllChildrenView
{

    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;

    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = CZNameFont;
    [self addSubview:nameView];
    _nameView = nameView;

    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;

    // 时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.font = CZTimeFont;
    timeView.textColor = [UIColor orangeColor];
    [self addSubview:timeView];
    _timeView = timeView;

    // 来源
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = CZSourceFont;
    [self addSubview:sourceView];
    _sourceView = sourceView;

    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = CZTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;

}
//重写视图模型的set方法
- (void)setStatusF:(ZYStatusFrame *)statusF
{
    _statusF = statusF;
    [self setUpFrame];
    [self setUpData];

}


- (void)setUpData
{
    ZYStatus *status = _statusF.status;
    // 头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];

    // 昵称
    if (status.user.vip) {
        _nameView.textColor = [UIColor redColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    _nameView.text = status.user.name;

    // vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    UIImage *image = [UIImage imageNamed:imageName];

    _vipView.image = image;

    // 时间
    _timeView.text = status.created_at;

    // 来源

    _sourceView.text = status.source;

    // 正文
    _textView.text = status.text;
}

- (void)setUpFrame
{
    // 头像
    _iconView.frame = _statusF.originalIconFrame;

    // 昵称
    _nameView.frame = _statusF.originalNameFrame;

    // vip
    if (_statusF.status.user.vip) { // 是vip
        _vipView.hidden = NO;
        _vipView.frame = _statusF.originalVipFrame;
    }else{
        _vipView.hidden = YES;
    }
    // 时间
    _timeView.frame = _statusF.originalTimeFrame;

    // 来源
    _sourceView.frame = _statusF.originalSourceFrame;

    // 正文
    _textView.frame = _statusF.originalTextFrame;


}




@end








