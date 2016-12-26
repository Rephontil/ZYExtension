//
//  ZYRetweetView.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/12/25.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "ZYRetweetView.h"
#import "ZYStatus.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ZYImage.h"
#import "ZYStatusFrame.h"

@interface ZYRetweetView ()
// 昵称
@property (nonatomic, weak) UILabel *nameView;


// 正文
@property (nonatomic, weak) UILabel *textView;


@end

@implementation ZYRetweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView
{

    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = CZNameFont;
    [self addSubview:nameView];
    _nameView = nameView;


    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = CZTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
}

- (void)setStatusF:(ZYStatusFrame *)statusF
{
    _statusF = statusF;

    ZYStatus *status = statusF.status;
    // 昵称
    _nameView.frame = statusF.retweetNameFrame;
    _nameView.text = status.retweeted_status.user.name;

    // 正文
    _textView.frame = statusF.retweetTextFrame;
    _textView.text = status.retweeted_status.text;
}


@end
