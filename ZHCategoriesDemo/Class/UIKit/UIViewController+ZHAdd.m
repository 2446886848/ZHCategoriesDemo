//
//  UIViewController+ZHAdd.m
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/14.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import "UIViewController+ZHAdd.h"

@implementation UIViewController (ZHAdd)

/**
 *  获取程序最前显示的UIViewController
 *
 *  @return 最前显示的UIViewController
 */
+ (UIViewController *)zh_topMostViewController
{
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (viewController) {
        if ([viewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabBarViewcontroller = (UITabBarController *)viewController;
            if (tabBarViewcontroller.viewControllers.count > 0) {
                viewController = tabBarViewcontroller.viewControllers[tabBarViewcontroller.selectedIndex];
                continue;
            }
            else
            {
                return tabBarViewcontroller;
            }
        }
        else if([viewController isKindOfClass:[UINavigationController class]])
        {
            UINavigationController *navigationcontroller = (UINavigationController *)viewController;
            if (navigationcontroller.viewControllers.count > 0) {
                viewController = navigationcontroller.topViewController;
                continue;
            }
            else
            {
                return navigationcontroller;
            }
        }
        else if([viewController isKindOfClass:[UIViewController class]])
        {
            if (viewController.presentedViewController) {
                viewController = viewController.presentedViewController;
                continue;
            }
            else
            {
                return viewController;
            }
        }
        else
        {
            return nil;
        }
    }
    return viewController;
}

@end
