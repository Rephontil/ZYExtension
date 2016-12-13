//
//  ZYNavigationController.m
//  NewWorldTime
//
//  Created by ZhouYong on 15/11/19.
//  Copyright © 2015年 ZhouYong. All rights reserved.
//

#import "ZYNavigationController.h"
#import "ZYTabBar.h"

@interface ZYNavigationController ()<UINavigationControllerDelegate>

/**滑动返回手势的代理**/
@property(nonatomic, strong)id popDelegate;

@end

@implementation ZYNavigationController


+ (void)initialize
{
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) { // 不是根控制器

        viewController.hidesBottomBarWhenPushed = YES;

        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        // 设置导航条的按钮
        viewController.navigationItem.leftBarButtonItem = left;

        UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popToRoot) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = right;
    }

    [super pushViewController:viewController animated:animated];

}

//直接到根视图控制器
- (void)popToRoot
{
    [self popToRootViewControllerAnimated:YES];
}
//返回上一级视图控制器
- (void)popToPre
{
    [self popViewControllerAnimated:YES];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;

    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[ZYTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    如果显示的是根控制器,就让系统支持滑动返回。
    if (viewController == self.viewControllers.firstObject) {
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else
    {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
