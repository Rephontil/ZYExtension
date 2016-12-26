//
//  ZYStatusCell.h
//  NewWorldTime
//
//  Created by ZhouYong on 16/12/25.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYStatusFrame; //ViewModel

@interface ZYStatusCell : UITableViewCell

/****/
@property(nonatomic, strong)ZYStatusFrame* statusF;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
