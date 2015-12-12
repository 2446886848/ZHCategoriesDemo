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

@end
