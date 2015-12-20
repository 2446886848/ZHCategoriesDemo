//
//  UIImage+ZHAdd.m
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/12.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import "UIImage+ZHAdd.h"
#import "UIView+ZHAdd.h"

@implementation UIImage (ZHAdd)

/**
 *  为一个图片增加透明边框
 *
 *  @param roundWidth 透明边框的宽度
 *
 *  @return 增加了周围透明的图片
 */
- (UIImage *)zh_imageWithClearRoundWidth:(CGFloat)roundWidth
{
    if (roundWidth < 0) {
        roundWidth = 0;
    }
    
    CGFloat imageWidth = self.size.width;
    CGFloat imageHeight = self.size.height;
    CGRect contextRect = CGRectMake(0, 0, imageWidth + roundWidth * 2, imageHeight + roundWidth * 2);
    
    UIGraphicsBeginImageContextWithOptions(contextRect.size, NO, 0.0);
    [self drawInRect:CGRectMake(roundWidth, roundWidth, imageWidth, imageHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

/**
 *  获取应用的启动图
 *
 *  @return 应用的启动图
 */
+ (instancetype)zh_launchImage
{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = @"Portrait";    //横屏请设置成 @"Landscape"
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    
    if (!launchImageName) {
        return nil;
    }
    NSString *launchImagePath = [self zh_availablePathWithImageName:launchImageName];

    return [UIImage imageWithContentsOfFile:launchImagePath];
}

/**
 *  根据传入的图片名称，查找适合的图片路径
 *
 *  @param imageName 图片名称
 *
 *  @return 图片路径
 */
+ (NSString *)zh_availablePathWithImageName:(NSString *)imageName
{
    //自带后缀名，直接返回文件路径
    if ([imageName componentsSeparatedByString:@"."].count >= 2) {
        return [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    }
    
    NSArray *scaleArr = nil;
    switch ((UInt8)[UIScreen mainScreen].scale) {
        case 3:
            scaleArr = @[@"3x", @"2x", @""];
            break;
        case 2:
            scaleArr = @[@"2x", @"", @"3x"];
            break;
        case 1:
            scaleArr = @[@"", @"2x", @"3x"];
            break;
        default:
            break;
    }
    
    for (NSString *scaleStr in scaleArr) {
        NSString *combinedImageName = [imageName stringByAppendingFormat:@"@%@.png", scaleStr];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:combinedImageName ofType:nil];
        if (imagePath) {
            return imagePath;
        }
    }
    return nil;
}


@end
