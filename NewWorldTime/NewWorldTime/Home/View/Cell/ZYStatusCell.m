//
//  ZYStatusCell.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/12/25.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//  微博的cell

#import "ZYStatusCell.h"
#import "ZYOriginalView.h"
#import "ZYRetweetView.h"
#import "ZYStatusToolBarView.h"
#import "ZYStatusFrame.h"

@interface ZYStatusCell ()


@property(nonatomic, strong)ZYOriginalView* originalView;
@property(nonatomic, strong)ZYRetweetView* retweetView;
@property(nonatomic, strong)ZYStatusToolBarView* toolBarView;


@end


@implementation ZYStatusCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        //添加子视图
        [self setUpAllChildrenView];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

//添加子视图
- (void)setUpAllChildrenView
{

    ZYOriginalView *originalView = [[ZYOriginalView alloc] init];
    _originalView = originalView;
    [self addSubview:originalView];

    ZYRetweetView *retweetView = [[ZYRetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;

    ZYStatusToolBarView *toolBarView = [[ZYStatusToolBarView alloc] init];
    [self addSubview:toolBarView];
    _toolBarView = toolBarView;

}

/*
 问题：1.cell的高度应该提前计算出来
 2.cell的高度必须要先计算出每个子控件的frame，才能确定
 3.如果在cell的setStatus方法计算子控件的位置，会比较耗性能

 解决:MVVM思想
 M:模型
 V:视图
 VM:视图模型（模型包装视图模型，模型+模型对应视图的frame）


 */


//重写ViewModel的set方法
- (void)setStatusF:(ZYStatusFrame *)statusF
{
    _statusF = statusF;
    _originalView.statusF = statusF;
    _originalView.frame = statusF.originalViewFrame;

    _retweetView.frame = statusF.retweetViewFrame;
    _retweetView.statusF = statusF;


    _toolBarView.frame = statusF.toolBarFrame;
    _toolBarView.statusF = statusF;


}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
