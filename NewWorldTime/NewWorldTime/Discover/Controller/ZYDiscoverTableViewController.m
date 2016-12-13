//
//  ZYDiscoverTableViewController.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/11/19.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "ZYDiscoverTableViewController.h"
#import "ZYSearchBar.h"

@interface ZYDiscoverTableViewController ()

@end

@implementation ZYDiscoverTableViewController

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ZYSearchBar *discoverSearchBar = [[ZYSearchBar alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 35)];
    discoverSearchBar.placeholder = @"大家都在搜索🔍";
    self.navigationItem.titleView = discoverSearchBar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


@end
