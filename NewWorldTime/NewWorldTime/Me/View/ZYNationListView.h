//
//  ZYNationListView.h
//  NewWorldTime
//
//  Created by ZhouYong on 16/12/26.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXLayoutButton.h"

@interface ZYNationListView : UIView

/**左侧的buttonView·**/
@property(nonatomic, strong)JXLayoutButton* leftButtonView;

/**右侧的箭头View·**/
@property (nonatomic, strong)UIButton *rightImage;


@end
