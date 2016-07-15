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

@interface UIImage (ZHAddForClip)

/**
 *  返回一个带透明圆角的图片
 *
 *  @return 带透明圆角的图片
 */
- (UIImage *)zh_cornerClipedImage;

/**
 *  返回一个带特定颜色圆角的图片
 *
 *  @param bgColor 四角颜色
 *
 *  @return 带特定颜色圆角的图片
 */
- (UIImage *)zh_cornerClipedImageWithBackGroundColor:(UIColor *)bgColor;

/**
 *  异步切图为圆角
 *
 *  @param block 切好图片之后的回调（会在主线程回调）
 */
- (void)zh_asyncCornerClipComplete:(void(^)(UIImage *newImage))block;

/**
 *  异步切图为圆角
 *
 *  @param pathBlock 切割路径
 *  @param block     切好图片之后的回调（会在主线程回调）
 */
- (void)zh_asyncCornerClipWithPath:(CGPathRef(^)(CGFloat imageWidth, CGFloat imageHeight))pathBlock complete:(void(^)(UIImage *newImage))block;

@end
