//
//  UIViewController+ZHAdd.h
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/14.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZHAdd)

/**
 *  获取程序最前显示的UIViewController
 *
 *  @return 最前显示的UIViewController
 */
+ (UIViewController *)zh_topMostViewController;

@end
