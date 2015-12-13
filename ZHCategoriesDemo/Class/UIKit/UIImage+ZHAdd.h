//
//  UIImage+ZHAdd.h
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/12.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZHAdd)

/**
 *  为一个图片增加透明边框
 *
 *  @param roundWidth 透明边框的宽度
 *
 *  @return 增加了周围透明的图片
 */
- (UIImage *)zh_imageWithClearRoundWidth:(CGFloat)roundWidth;

/**
 *  获取应用的启动图
 *
 *  @return 应用的启动图
 */
+ (instancetype)zh_launchImage;

/**
 *  根据传入的图片名称，查找适合的图片路径
 *
 *  @param imageName 图片名称
 *
 *  @return 图片路径
 */
+ (NSString *)zh_availablePathWithImageName:(NSString *)imageName;

@end
