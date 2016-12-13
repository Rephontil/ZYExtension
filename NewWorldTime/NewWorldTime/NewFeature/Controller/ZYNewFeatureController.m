//
//  ZYNewFeatureController.m
//  NewWorldTime
//
//  Created by ZhouYong on 16/11/21.
//  Copyright © 2016年 ZhouYong. All rights reserved.
//  新特性视图控制器

#import "ZYNewFeatureController.h"
#import "ZYNewFeatureCell.h"

@interface ZYNewFeatureController ()<ZYNewFeatureCellDelegate>

@property(nonatomic, weak)UIPageControl *pageControl;

@end

@implementation ZYNewFeatureController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    if (self = [super initWithCollectionViewLayout:layout]) {

    }return self;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = 4;
        pageControl.pageIndicatorTintColor = [UIColor cyanColor];
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        pageControl.center = CGPointMake(K_SCREEN_WIDTH/2.0, K_SCREEN_HEIGHT - 20);
        [self.view addSubview:pageControl];
        _pageControl = pageControl;

    }
    return _pageControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerClass:[ZYNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = YES;

    [self pageControl];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];

    cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1]];

    [cell setViewAtIndexPath:indexPath pageCount:4];
    cell.delegate = self;

    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / K_SCREEN_WIDTH ;
//    ZYLog(@"%d",page);
    _pageControl.currentPage = page;


}

#pragma mark ZYNewFeatureCellDelegate

- (void)delegateTestComplete
{
    NSLog(@"delegateTestComplete代理测试成功了");
//    itcastweibo@163.com  itcast

}

@end
