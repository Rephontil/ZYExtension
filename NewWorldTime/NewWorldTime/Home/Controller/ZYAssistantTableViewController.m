//
//  ZYAssistantTableViewController.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/11/20.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import "ZYAssistantTableViewController.h"

@interface ZYAssistantTableViewController ()

@end

@implementation ZYAssistantTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;


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

    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;

}




@end
