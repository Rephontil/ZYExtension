//
//  ZYNewFeatureCell.h
//  NewWorldTime
//
//  Created by ZhouYong on 16/11/21.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYNewFeatureCell;

@protocol ZYNewFeatureCellDelegate <NSObject>

@required

- (void)delegateTestComplete;

@end


@interface ZYNewFeatureCell : UICollectionViewCell

@property(nonatomic, strong)UIImage  *image;

@property (nonatomic, weak)id<ZYNewFeatureCellDelegate> delegate;

/**
 在最后一页显示分享和开始的按钮

 @param indexPath 传入当前page的坐标
 @param pageCount 一共有多少页要显示
 */
- (void)setViewAtIndexPath:(NSIndexPath *)indexPath pageCount:(NSInteger)pageCount;

@end
