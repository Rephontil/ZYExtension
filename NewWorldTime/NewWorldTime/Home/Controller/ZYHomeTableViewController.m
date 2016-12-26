//
//  ZYHomeTableViewController.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/11/20.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "ZYHomeTableViewController.h"
#import "ZYAssistantTableViewController.h"
#import "ZYTitleButton.h"
#import "ZYCover.h"
#import "ZYPopMenu.h"
#import <AFNetworking.h>
#import "ZYAccountTool.h"
#import "ZYAccount.h"
#import "ZYStatus.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>

#import "ZYHttpTool.h"
#import "ZYStatusTool.h"
#import "ZYStatusPara.h"

#import "ZYStatusCell.h"
#import "ZYStatusFrame.h"


@interface ZYHomeTableViewController ()<ZYCoverDelegate>
@property(nonatomic, weak)ZYTitleButton* titleButton;
@property(nonatomic, strong)ZYAssistantTableViewController* assistantTBVC;

/**
 存放数据源模型数组
 */
@property (nonatomic, strong)NSMutableArray *status;

/**
 存放ViewModel数组
 */
@property (nonatomic, strong)NSMutableArray *statusF;



@end

@implementation ZYHomeTableViewController

static NSString * const reuseHomeTableViewCellID = @"cell";


- (ZYAssistantTableViewController *)assistantTBVC
{
    if (_assistantTBVC == nil) {
        _assistantTBVC = [[ZYAssistantTableViewController alloc] init];
    }
    return _assistantTBVC;
}

- (NSMutableArray *)status
{
    if (_status == nil) {
        _status = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _status;
}

- (NSMutableArray *)statusF
{
    if (_statusF == nil) {
        _statusF = [[NSMutableArray alloc] initWithCapacity:1];
    }return _statusF;
}

// UIBarButtonItem:决定导航条上按钮的内容
// UINavigationItem:决定导航条上内容
// UITabBarItem:决定tabBar上按钮的内容
// ios7之后，会把tabBar上和导航条上的按钮渲染
// 导航条上自定义按钮的位置是由系统决定，尺寸才需要自己设置。

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];

    [self refreshTableView];

    self.tableView.tableFooterView = [UIView new];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 10;

}


- (void)refreshTableView
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       // [self getData];

        [self otherMethodNewStatus];
    }];
    [self.tableView.mj_header beginRefreshing ];

    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       //[self loadMoreData];
        [self otherMethodMoreStatus];
    }];
}

#pragma mark  --获取微博数据
- (void)getData
{
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    paraDic[@"access_token"] = [ZYAccountTool account].access_token;

    if (self.status.count) {
        paraDic[@"since_id"] = [self.status.firstObject idstr];
    }
    [ZYHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:paraDic progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        ZYLog(@"ZYHttpTool -->%@",responseObject);

        [self.tableView.mj_header endRefreshing];

     //   字典数组
        NSArray *dataArr = responseObject[@"statuses"];

        NSArray *status = [ZYStatus mj_objectArrayWithKeyValuesArray:dataArr];
        
        [self.status addObjectsFromArray:status];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, status.count)];

       // NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:status.count];
        [self.status insertObjects:status atIndexes:indexSet];
        
        [self.tableView reloadData];


    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];

}

- (void)otherMethodNewStatus
{
    NSString *sinceId = nil;
    if (self.statusF.count) {

        ZYStatus *status = [self.statusF[0] status];
        sinceId = [status idstr];

    }
    [ZYStatusTool newStatusWithSinceId:sinceId success:^(NSArray *modelArray) {

        [self showNewStatusCount:modelArray.count];
        [self.tableView.mj_header endRefreshing];

        // 模型转换视图模型 CZStatus -> CZStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (ZYStatus *status in modelArray) {
            ZYStatusFrame *statusF = [[ZYStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];

        }


        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, modelArray.count)];
        [self.statusF insertObjects:statusFrames atIndexes:indexSet];

        [self.tableView reloadData];

    } failure:^(NSError *error) {
        ZYLog(@"失败了");
        
    }];
}


#pragma mark 获取以前的微博数据
- (void)loadMoreData
{
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];

    paraDic[@"access_token"] = [ZYAccountTool account].access_token;

    long long max_id = [self.status.lastObject idstr].integerValue - 1;
    paraDic[@"max_id"] = [NSString stringWithFormat:@"%lld",max_id];

    [ZYHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:paraDic progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        [self.tableView.mj_footer endRefreshing];

        NSArray *dicArray = responseObject[@"statuses"];
        NSArray *status = [ZYStatus mj_objectArrayWithKeyValuesArray:dicArray];
        [self.status addObjectsFromArray:status];
        [self.tableView reloadData];


    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];

}


- (void)otherMethodMoreStatus
{
//    1️⃣设计思路：从数据层获取数据。
//    目的：获取到更多的旧数据。
//    条件：需要参数maxid。
//    目标输出(传递给我的数据)：数据成功的block（输出模型数组给我）。  数据失败的block（失败的原因给我）
    NSString *maxid = nil;
    if (self.statusF.count) {
        ZYStatus *status = [self.statusF.lastObject status];

        maxid = [NSString stringWithFormat:@"%lld",[status.idstr longLongValue]-1];

    }

    [ZYStatusTool moreStatusWithMaxId:maxid success:^(NSArray *modelArray) {

        [self.tableView.mj_footer endRefreshing];
        NSMutableArray *statusFrame = [[NSMutableArray alloc] initWithCapacity:1];
        for (ZYStatus *stauts in modelArray) {
            ZYStatusFrame *statusF = [[ZYStatusFrame alloc] init];
            statusF.status = stauts;
            [statusFrame addObject:statusF];
            
        }
        [self.statusF addObjectsFromArray:statusFrame];
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        ZYLog(@"失败了");

    }];
    
}

#pragma mark - 展示最新的微博数
-(void)showNewStatusCount:(NSInteger)count
{
    if (count == 0) return;

    // 展示最新的微博数
    CGFloat h = 35;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    CGFloat x = 0;
    CGFloat w = self.view.width;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];

    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"最新微博数%ld",count];

    label.textAlignment = NSTextAlignmentCenter;

    // 插入导航控制器下导航条下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];


    // 动画往下面平移
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, h);

    } completion:^(BOOL finished) {


        // 往上面平移
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{

            // 还原
            label.transform = CGAffineTransformIdentity;

        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];

    }];

}



- (void)setUpNavigationBar
{
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];

    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];

    ZYTitleButton *titleButton = [ZYTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    [_titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [_titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [_titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    [_titleButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

    self.titleButton.adjustsImageWhenHighlighted = NO;
    _titleButton.adjustsImageWhenDisabled = NO;
    self.navigationItem.titleView = _titleButton;

}

- (void)friendsearch
{

}

- (void)pop
{


}

- (void)buttonClick:(UIButton *)button
{
    button.selected = !button.selected;
    // 弹出蒙板
    ZYCover *cover = [ZYCover show];
    cover.delegate = self;

    // 弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    ZYPopMenu *menu = [ZYPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.assistantTBVC.view;

}
- (void)coverDidClickCover:(ZYCover *)cover
{
    [ZYPopMenu hide];
    _titleButton.selected = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    return self.status.count;

    return self.statusF.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseHomeTableViewCellID];
//
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseHomeTableViewCellID];
//    }
//
//    ZYStatus *status = self.status[indexPath.row];
//    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"movie"]];
//    cell.textLabel.text = status.created_at;
//    cell.detailTextLabel.text = status.text;
//    return cell;

    ZYStatusCell *cell = [ZYStatusCell cellWithTableView:tableView];
    ZYStatusFrame *statusF = self.statusF[indexPath.row];
    cell.statusF = statusF;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYStatusFrame *statusF = self.statusF[indexPath.row];
    return  statusF.cellHeight;
    
}





@end
