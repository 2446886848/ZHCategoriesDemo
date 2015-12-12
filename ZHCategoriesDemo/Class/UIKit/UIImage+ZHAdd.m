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

@end
