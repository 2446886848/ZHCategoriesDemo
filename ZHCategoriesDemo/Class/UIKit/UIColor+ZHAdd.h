//
//  UIColor+ZHAdd.h
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/10.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZHAdd)

/**
 *  使用rgb组合值创建UIColor对象
 *
 *  @param rgbValue rgb组合值
 *
 *  @return UIColor对象
 */
+ (instancetype)zh_colorWithRGB:(NSInteger)rgbValue;

/**
 *  使用rgb组合值创建UIColor对象
 *
 *  @param rgbValue rgbValue rgb组合值
 *  @param alpha    透明度
 *
 *  @return UIColor对象
 */
+ (instancetype)zh_colorWithRGB:(NSInteger)rgbValue alpha:(CGFloat)alpha;

/**
 *  获取颜色的rgb值
 *
 *  @return 颜色的rgb值
 */
- (NSInteger)zh_RGBValue;

- (NSInteger)zh_rValue;

- (NSInteger)zh_gValue;

- (NSInteger)zh_bValue;

- (CGFloat)zh_aValue;

@end
