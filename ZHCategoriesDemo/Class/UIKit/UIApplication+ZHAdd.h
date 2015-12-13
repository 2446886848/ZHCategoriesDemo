//
//  UIApplication+ZHAdd.h
//  ZHCategoriesDemo
//
//  Created by 吴志和 on 15/12/13.
//  Copyright © 2015年 wuzhihe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (ZHAdd)

/**
 *  获取当前应用的Documents目录的URL
 *
 *  @return Documents目录的URL
 */
+ (NSURL *)zh_documentUrl;

/**
 *  获取当前应用的Documents目录的路径
 *
 *  @return Documents目录的路径
 */
+ (NSString *)zh_documentPath;

/**
 *  获取当前应用的Library目录的URL
 *
 *  @return @return Library目录的URL
 */
+ (NSURL *)zh_libraryUrl;

/**
 *  获取当前应用的Library目录的路径
 *
 *  @return Library目录的路径
 */
+ (NSString *)zh_libraryPath;

/**
 *  获取当前应用的Caches目录的URL
 *
 *  @return @return Caches目录的URL
 */
+ (NSURL *)zh_cacheUrl;

/**
 *  获取当前应用的Caches目录的路径
 *
 *  @return Caches目录的路径
 */
+ (NSString *)zh_cachePath;

@end
