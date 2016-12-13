//
//  UIImage+ZYImage.m
//  NewWorldTime
//
//  Created by ZhouYong on 15/1/16.
//  Copyright © 2015年 ZhouYong. All rights reserved.
//

#import "UIImage+ZYImage.h"

@implementation UIImage (ZYImage)

/**
 返回image最原始的样式（用于阻止系统帮我们渲染图片）

 @param imageName 要传入的图片名称
 @return 最原始的图片（不被渲染）
 */
+ (UIImage *)imageWithRenderingModelAlwaysOriginalWithImageName:(NSString *)imageName
{
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return  image;
}


/**
 一张非矩形的小图片在被拉伸的时候，保证图片的边角不要变形。
·
 @param imageName 要被拉伸的图片
 @return 边角没有变形的拉伸图片
 */
+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}


@end
