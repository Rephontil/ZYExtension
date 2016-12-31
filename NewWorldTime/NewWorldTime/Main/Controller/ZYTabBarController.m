//
//  ZYTabBarController.m
//  NewWorldTime
//
//  Created by ZhouYong on 15/11/16.
//  Copyright © 2015年 ZhouYong. All rights reserved.
//

#import "ZYTabBarController.h"
#import "UIImage+ZYImage.h"
//#import <objc/objc-runtime.h>
#import "ZYTabBar.h"
#import "ZYDiscoverTableViewController.h"
#import "ZYNavigationController.h"
#import "ZYHomeTableViewController.h"
#import "ZYNationListView.h"

@interface ZYTabBarController ()
{
    ZYNationListView* view;

}
@end


@implementation ZYTabBarController

+(void)load
{

}

//当程序调用调用当前这个类或者其子类的时候调用这个方法
+ (void)initialize{

    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];

    NSMutableDictionary *attributesDic = [NSMutableDictionary dictionary];
    attributesDic[NSFontAttributeName] = [UIFont systemFontOfSize:30];
    attributesDic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:attributesDic forState:UIControlStateSelected];

}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTabBarController];

    self.view.backgroundColor = [UIColor whiteColor];

    ZYTabBar *tabBar = [[ZYTabBar alloc] initWithFrame:self.tabBar.frame];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    ZYLog(@"%@---->%@",self.tabBar, self.tabBar.subviews);

}

- (void)setUpTabBarController
{
    ZYHomeTableViewController *VC1 = [[ZYHomeTableViewController alloc] init];
    [self setUpChildViewController:VC1 withBadgeValue:@"9" normalImageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected" withTitle:@"首页"];
    VC1.view.backgroundColor = [UIColor whiteColor];

    UIViewController *VC2 = [[UIViewController alloc] init];
    [self setUpChildViewController:VC2 withBadgeValue:@"-4" normalImageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected" withTitle:@"消息"];
    VC2.view.backgroundColor = [UIColor whiteColor];

    ZYDiscoverTableViewController *VC3 = [[ZYDiscoverTableViewController alloc] init];
    [self setUpChildViewController:VC3 withBadgeValue:@"-4" normalImageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected" withTitle:@"发现"];

    UIViewController *VC4 = [[UIViewController alloc] init];
    [self setUpChildViewController:VC4 withBadgeValue:@"7" normalImageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected" withTitle:@"我"];
    VC4.view.backgroundColor = [UIColor whiteColor];

    view = [[ZYNationListView alloc] initWithFrame:CGRectMake(20, 100, K_SCREEN_WIDTH/2 - 20, 40)];
    view.leftButtonView.userInteractionEnabled = NO;
    [view.leftButtonView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view.leftButtonView setTitle:@"选择国家旗" forState:UIControlStateNormal];
    [view.leftButtonView setImage:[UIImage imageNamed:@"pay"] forState:UIControlStateNormal];
    [view.rightImage setImage:[UIImage imageNamed:@"vip"] forState:UIControlStateNormal];
    [view.rightImage setImage:[UIImage imageNamed:@"like"] forState:UIControlStateHighlighted];
    [view.rightImage addTarget:self action:@selector(nationChoose:) forControlEvents:UIControlEventTouchUpInside];
    [VC4.view addSubview:view];

}

- (void)nationChoose:(UIButton *)button
{
    ZYLog(@"%s",__func__);
    [view.leftButtonView setTitle:@"已选择中国" forState:UIControlStateNormal];
    [view.leftButtonView setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
}

- (UIViewController *)setUpChildViewController:(UIViewController *)uiViewController
                  withBadgeValue:(NSString *)badgeValue
                 normalImageName:(NSString *)normalImageName
               selectedImageName:(NSString *)selectedImageName
                       withTitle:(NSString *)title
{
    uiViewController.tabBarItem.title = title;
    //如果有新的消息提醒就显示出来，否则不显示（值不为空，值大于0）
    if (!(badgeValue.length ==0 || badgeValue.integerValue <= 0 || [badgeValue isEqual:nil])) {

        uiViewController.tabBarItem.badgeValue = badgeValue;
    }
    uiViewController.tabBarItem.image = [UIImage imageNamed:normalImageName];
    uiViewController.tabBarItem.selectedImage = [UIImage imageWithRenderingModelAlwaysOriginalWithImageName:selectedImageName];

    ZYNavigationController *nav = [[ZYNavigationController alloc] initWithRootViewController:uiViewController];
    [self addChildViewController:nav];
    return  uiViewController;
}



@end
